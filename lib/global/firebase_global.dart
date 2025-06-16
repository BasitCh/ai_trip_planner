
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel_hero/src/domain/itinerary/activity.dart';
import 'package:travel_hero/src/domain/itinerary/day_plan.dart';
import 'package:travel_hero/src/domain/itinerary/travel_itinerary.dart';
import 'package:widgets_book/widgets_book.dart';

Future<List<TravelItinerary>> fetchDaysAndActivitiesParallel({
  QuerySnapshot<Map<String, dynamic>>? querySnapshot, // Option 1: Full QuerySnapshot
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? queryDocs, // Option 2: List of documents
  required FirebaseAuth auth,
  required FirebaseFirestore firestore,
}) async {
  if (querySnapshot == null && queryDocs == null) {
    throw Exception("Both `querySnapshot` and `queryDocs` cannot be null.");
  }

  // ✅ Select docs from either `querySnapshot` or `queryDocs`
  List<QueryDocumentSnapshot<Map<String, dynamic>>> docs =
      querySnapshot?.docs ?? queryDocs!;

  // ✅ Parallel fetching of itineraries
  List<Future<TravelItinerary>> itineraryFutures = docs.map((doc) async {
    final itineraryData = doc.data();
    final itineraryId = doc.id;
    final isPaid = itineraryData['isPaidPlan'] as bool? ?? false;
    final unlockedBy = itineraryData['unlockedBy'] as List<dynamic>? ?? [];

    final daysRef = firestore
        .collection(FirestoreCollection.itineraries)
        .doc(itineraryId)
        .collection(FirestoreCollection.days)
        .orderBy('day');

    // ✅ Fetch `days` in parallel for all itineraries
    final daysSnapshot = await daysRef.get();
    final List<QueryDocumentSnapshot<Map<String, dynamic>>> dayDocs =
        daysSnapshot.docs;

    // ✅ Parallel fetching of `activities` for all days
    List<Future<DayPlan>> dayFutures = dayDocs.map((dayDoc) async {
      final dayData = dayDoc.data();
      final dayId = dayDoc.id;

      final activitiesRef = dayDoc.reference.collection(FirestoreCollection.activities);
      final activitiesSnapshot = await activitiesRef.get();

      final activities = activitiesSnapshot.docs
          .map((activityDoc) => Activity.fromJson(activityDoc.data()).copyWith(id: activityDoc.id))
          .toList();

      return DayPlan.fromJson(dayData).copyWith(
        id: dayId,
        activities: activities,
      );
    }).toList();

    // ✅ Wait for all days & activities to load in parallel
    final dayPlans = await Future.wait(dayFutures);

    // ✅ Determine if itinerary is unlocked for the current user
    final isUnlockedForCurrentUser =
        isPaid ? unlockedBy.contains(auth.currentUser?.uid) : true;

    return TravelItinerary.fromJson(itineraryData).copyWith(
      id: itineraryId,
      dayPlans: dayPlans,
      isUnlockedForCurrentUser: isUnlockedForCurrentUser,
    );
  }).toList();

  return await Future.wait(itineraryFutures);
}
