import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_hero/global/internet.dart';

abstract class OfflineSupportedSingleDataRepository<T> {
  final String _hiveBoxName;
  T? _data;
  final _dataSubject = BehaviorSubject<T>();
  Stream<T> get data => _dataSubject.stream;

  OfflineSupportedSingleDataRepository(this._hiveBoxName);

  Future<Either<Exception, T>> fetch() async {
    final Either<Exception, T> response;
    if (await Internet.hasInternetConnection()) {
      response = await fetchFromApi();
    } else {
      response = await fetchFromLocalDb();
      setupInConnectionWatcher();
    }

    response.fold(
      (exception) => debugPrint("Error: fetch ${exception.toString()}"),
      (data) => updateData(data),
    );

    return response;
  }

  Future<Either<Exception, T>> fetchFromApi();

  Future<Either<Exception, T>> fetchFromLocalDb() async {
    if (await offlineInitializable() == false || kIsWeb) return Left(Exception("No data in local DB "));
    var box = await Hive.openBox(_hiveBoxName);
    final data = box.get("${_hiveBoxName}_primary-data");
    if (data != null && data is T) return Right(data);
    return Left(Exception("No data in local DB"));
  }

  setupInConnectionWatcher() async {
    await Internet.internetConnectionStateStream.firstWhere((state) => state == InternetConnectionStatus.connected);
    fetchFromApi();
  }

  Future _saveToLocalDB(T? data) async {
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
      if(doesBoxExists) Hive.deleteBoxFromDisk(_hiveBoxName);
      debugPrint("_saveToLocalDB: $e");
    }
  }

  updateData(T data) async {
    _data = data;
    _dataSubject.add(data);
    if (kIsWeb == false) await _saveToLocalDB(data);
  }

  T? get currentData => _data;

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
