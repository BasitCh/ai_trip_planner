import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';

import '../../src/domain/itinerary/request/mood.dart';

class AppConfigRepository {
  final FirebaseFirestore _firestore;

  AppConfigRepository(this._firestore);

  /// ✅ Load App Modes (Moods) from Firestore
  Future<Either<Exception, List<Mood>>> loadAppModes() async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection('app_config')
          .doc('app_mood')
          .get();

      if (!snapshot.exists) {
        return left(Exception("app_mood document not found"));
      }

      final data = snapshot.data();

      if (data == null || !data.containsKey('moods')) {
        return left(Exception("Mood array not found in app_mood document"));
      }

      final List<dynamic> moodList = data['moods'] as List<dynamic>;

      /// ✅ Convert Firestore Data to List of `Mood`
      final List<Mood> moods = moodList.map((moodName) {
        if (moodName is String) {
          return Mood(name: moodName, isSelected: false);  // Assuming default is not selected
        } else {
          throw Exception("Invalid mood format: Expected a string.");
        }
      }).toList();

      return right(moods);
    } catch (e) {
      log("❌ Error fetching App Moods: $e");
      return left(Exception("Failed to load App Moods: $e"));
    }
  }
}
