import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:travel_hero/global/firebase_global.dart';
import 'package:travel_hero/repositories/offline_extension/offline_supported_list_data_repository.dart';
import 'package:travel_hero/src/application/main/cubit/drawer_cubit.dart';
import 'package:travel_hero/src/domain/itinerary/travel_itinerary.dart';
import 'package:travel_hero/src/infrastructure/utils/constants.dart';
import 'package:widgets_book/widgets_book.dart';

class OfflineItineraryRepository
    extends OfflineSupportedListDataRepository<TravelItinerary> {
  OfflineItineraryRepository(this._firebaseAuth, this._fireStore)
      : super(HiveBoxes.travelItineraries) {
    _resetPagination();
  }

  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _fireStore;

  DocumentSnapshot? _lastFetchedDocument;
  bool hasMoreData = true;
  final _documentLimit = 10;
  final List<TravelItinerary> _globalItineraries = [];

  @override
  Future<Either<Exception, List<TravelItinerary>>> fetchFromApi({
    bool? isInternetReconnected,
  }) async {
    log('has more data: $hasMoreData');

    log('Fetching itineraries from API');
    if (isInternetReconnected == true) {
      _resetPagination();
    }
    if (!hasMoreData) {
      return right([]);
    }

    try {
      final response = isTravelerMode
          ? await _fetchAllItineraries()
          : await _fetchUserItineraries();
      return response.fold(
        (exception) => left(exception),
        (itineraries) {
          if (isInternetReconnected == true) {
            updateData(itineraries);
          }
          return right(itineraries);
        },
      );
    } catch (e) {
      return left(Exception('Unexpected error occurred: $e'));
    }
  }

  /// 🚀 Lazy Load: Only fetch **summary** itineraries
  Future<Either<Exception, List<TravelItinerary>>>
      _fetchAllItineraries() async {
    final userId = _firebaseAuth.currentUser?.uid;
    if (userId == null) return left(Exception('No user id'));

    try {
      Query<Map<String, dynamic>> query = _fireStore
          .collection(FirestoreCollection.itineraries)
          .orderBy('createdAt', descending: true)
          .limit(_documentLimit);

      if (_lastFetchedDocument != null) {
        query = query.startAfterDocument(_lastFetchedDocument!);
      }

      final querySnapshot = await query.get();

      if (querySnapshot.docs.isEmpty) {
        hasMoreData = false;
        return right([]);
      }

      final itineraries = querySnapshot.docs
          .map((doc) {
            final data = doc.data();
            final isPaid = data['isPaidPlan'] as bool? ?? false;
            final unlockedBy = data['unlockedBy'] as List<dynamic>? ?? [];
            final isUnlocked = isPaid ? unlockedBy.contains(userId) : true;

            return TravelItinerary.fromJson(data).copyWith(
              id: doc.id,
              dayPlans: [], // Empty for now – lazy load later
              isUnlockedForCurrentUser: isUnlocked,
            );
          })
          .where((itinerary) =>
              itinerary.userId != userId ||
              (itinerary.visibility?.allowedUsers.contains(userId) ?? false))
          .toList();

      _lastFetchedDocument = querySnapshot.docs.last;
      hasMoreData = querySnapshot.docs.length == _documentLimit;
      _globalItineraries.addAll(itineraries);

      return right(itineraries);
    } catch (e) {
      return left(Exception('Failed to fetch all itineraries: $e'));
    }
  }

  /// ✅ Fetch summaries for **owner's** itineraries only
  Future<Either<Exception, List<TravelItinerary>>>
      _fetchUserItineraries() async {
    final userId = _firebaseAuth.currentUser?.uid;
    if (userId == null) return left(Exception('No user id'));

    try {
      Query<Map<String, dynamic>> query = _fireStore
          .collection(FirestoreCollection.itineraries)
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .limit(_documentLimit);

      if (_lastFetchedDocument != null) {
        query = query.startAfterDocument(_lastFetchedDocument!);
      }

      final querySnapshot = await query.get();

      if (querySnapshot.docs.isEmpty) {
        hasMoreData = false;
        return right([]);
      }

      final itineraries = querySnapshot.docs.map((doc) {
        final data = doc.data();
        final isPaid = data['isPaidPlan'] as bool? ?? false;
        final unlockedBy = data['unlockedBy'] as List<dynamic>? ?? [];
        final isUnlocked = isPaid ? unlockedBy.contains(userId) : true;

        return TravelItinerary.fromJson(data).copyWith(
          id: doc.id,
          dayPlans: [],
          isUnlockedForCurrentUser: isUnlocked,
        );
      }).toList();

      _lastFetchedDocument = querySnapshot.docs.last;
      hasMoreData = querySnapshot.docs.length == _documentLimit;
      _globalItineraries.addAll(itineraries);

      return right(itineraries);
    } catch (e) {
      return left(Exception('Failed to fetch user itineraries: $e'));
    }
  }

  Future<Either<Exception, List<TravelItinerary>>> fetchNextPage() async {
    if (!hasMoreData) return right([]);
    return isTravelerMode
        ? await _fetchAllItineraries()
        : await _fetchUserItineraries();
  }

  Future<Either<Exception, TravelItinerary>> fetchItineraryDetails(
      {required String? itineraryId}) async {
    try {
      // Use a query to get a QuerySnapshot (so we get QueryDocumentSnapshot)
      final querySnapshot = await _fireStore
          .collection(FirestoreCollection.itineraries)
          .where(FieldPath.documentId, isEqualTo: itineraryId)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return left(Exception("Itinerary not found"));
      }

      final fullItineraryList = await fetchDaysAndActivitiesParallel(
        querySnapshot: querySnapshot,
        auth: _firebaseAuth,
        firestore: _fireStore,
      );

      return right(fullItineraryList.first);
    } catch (e) {
      return left(Exception("Failed to fetch itinerary details: $e"));
    }
  }

  void resetData() {
    _resetPagination();
    fetch();
  }

  void _resetPagination() {
    _lastFetchedDocument = null;
    hasMoreData = true;
    _globalItineraries.clear();
    updateData([]);
  }
}
