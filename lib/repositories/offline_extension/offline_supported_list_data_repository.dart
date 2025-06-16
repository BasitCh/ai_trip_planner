import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_hero/global/internet.dart';

abstract class OfflineSupportedListDataRepository<T> {
  final String _hiveBoxName;
  List<T>? _data;
  final _dataSubject = BehaviorSubject<List<T>>();

  Stream<List<T>> get data => _dataSubject.stream;

  bool watchingInternetConnection = false;

  OfflineSupportedListDataRepository(this._hiveBoxName);

  Future<Either<Exception, List<T>>> fetch() async {
    Either<Exception, List<T>>? response;
    if (await Internet.hasInternetConnection()) {
      try {
        response = await fetchFromApi();
      } catch (e) {
        debugPrint("Error fetchFromApi => $runtimeType, with $e");
      }
    }

    if (response == null) {
      response = await fetchFromLocalDb();
      setupInternetConnectionWatcher();
    }

    response.fold(
      (exception) => debugPrint("Error: fetch ${exception.toString()}"),
      (data) => updateData(data),
    );

    return response;
  }

  Future<Either<Exception, List<T>>> fetchFromApi({bool? isInternetReconnected});

  Future<Either<Exception, List<T>>> fetchFromLocalDb() async {
    if (await offlineInitializable() == false) return Left(Exception("No data in local DB "));
    var box = await Hive.openBox(_hiveBoxName);
    final data = box.get("${_hiveBoxName}_primary-data");
    if (data != null) return Right(List<T>.from(data));
    return Left(Exception("No data in local DB"));
  }

  setupInternetConnectionWatcher() async {
    watchingInternetConnection = true;
    await Internet.internetConnectionStateStream.firstWhere((state) => state == InternetConnectionStatus.connected);
    fetchFromApi(isInternetReconnected: true);
  }

  Future afterInternetGetsConnectedAgain() async {
    //todo check if data is older than 1 day and not init yet otherwise don't download when not necessary.
    //don't download course and user etc.
    //do download lesson_progress.
    return fetchFromApi();
  }

  Future _saveToLocalDB(List<T>? data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      var box = await Hive.openBox(_hiveBoxName);
      if (data == null) {
        await box.clear();
      } else {
        await box.put("${_hiveBoxName}_primary-data", data);
        prefs.setString("${_hiveBoxName}_timestamp", DateTime.now().toIso8601String());
      }
    } catch (e) {
      final doesBoxExists = await Hive.boxExists(_hiveBoxName);
      if (doesBoxExists) Hive.deleteBoxFromDisk(_hiveBoxName);
      debugPrint("_saveToLocalDB: $e");
    }
  }

  updateData(List<T> data) async {
    _data = data;
    _dataSubject.add(data);
    await _saveToLocalDB(data);
  }

  List<T>? get currentData => _data;

  Future<bool> offlineInitializable() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final lastTimestamp = DateTime.tryParse(prefs.getString("${_hiveBoxName}_timestamp") ?? "");
    if (lastTimestamp != null && lastTimestamp.isAfter(DateTime.now().subtract(const Duration(days: 30)))) return true;
     _saveToLocalDB(null);
    return false;
  }

  Future dispose() {
    return _dataSubject.close();
  }
}
