import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:travel_hero/src/domain/itinerary/travel_itinerary.dart';
import 'package:widgets_book/widgets_book.dart';

enum ItineraryFilterType { all, custom, unlocked }

class FilteredItineraryRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  DocumentSnapshot? _lastFetchedDoc;
  final int _documentLimit = 10;
  bool hasMore = true;

  FilteredItineraryRepository({
    required this.firestore,
    required this.auth,
  });

  void reset() {
    _lastFetchedDoc = null;
    hasMore = true;
  }

  Future<Either<Exception, List<TravelItinerary>>> fetchFilteredItineraries({
    required ItineraryFilterType filterType,
    bool isRefresh = false,
  }) async {
    final userId = auth.currentUser?.uid;
    if (userId == null) return left(Exception("User not authenticated"));

    if (isRefresh) reset();

    try {
      Query<Map<String, dynamic>> query = firestore
          .collection(FirestoreCollection.itineraries)
          .orderBy('createdAt', descending: true)
          .limit(_documentLimit);

      if (_lastFetchedDoc != null) {
        query = query.startAfterDocument(_lastFetchedDoc!);
      }

      final snapshot = await query.get();

      if (snapshot.docs.isEmpty) {
        hasMore = false;
        return right([]);
      }

      _lastFetchedDoc = snapshot.docs.last;
      hasMore = snapshot.docs.length == _documentLimit;

      final filtered = _applyTravelerFilter(
        snapshot.docs.map((doc) {
          final data = doc.data();
          return TravelItinerary.fromJson(data).copyWith(
            id: doc.id,
            dayPlans: [],
            isUnlockedForCurrentUser: (data['isPaidPlan'] ?? false)
                ? (data['unlockedBy'] ?? []).contains(userId)
                : true,
          );
        }).toList(),
        userId,
        filterType,
      );

      return right(filtered);
    } catch (e) {
      return left(Exception("Failed to fetch itineraries: $e"));
    }
  }

  List<TravelItinerary> _applyTravelerFilter(
    List<TravelItinerary> itineraries,
    String userId,
    ItineraryFilterType filterType,
  ) {
    return itineraries.where((itinerary) {
      if (itinerary.userId == userId) return false;

      final visibility = itinerary.visibility;
      final isCustom = (visibility?.allowedUsers.contains(userId) ?? false) &&
          visibility?.type == 'private' &&
          (itinerary.isRequestedItinerary ?? false);
      final isUnlocked = itinerary.unlockedBy?.contains(userId) ?? false;

      switch (filterType) {
        case ItineraryFilterType.all:
          return isCustom || isUnlocked;
        case ItineraryFilterType.custom:
          return isCustom;
        case ItineraryFilterType.unlocked:
          return isUnlocked;
      }
    }).toList();
  }
}
