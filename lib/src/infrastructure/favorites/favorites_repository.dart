import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:travel_hero/global/firebase_global.dart';
import 'package:travel_hero/src/domain/favorites/collection.dart';
import 'package:travel_hero/src/domain/favorites/i_favorites_itinerary_repository.dart';
import 'package:travel_hero/src/domain/itinerary/travel_itinerary.dart';
import 'package:widgets_book/widgets_book.dart';

class FavoritesRepository implements IFavoritesItineraryRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _fireStore;

  FavoritesRepository(this._firebaseAuth, this._fireStore);

  @override
  Stream<Set<String>> watchUserFavorites() {
    final userId = _firebaseAuth.currentUser?.uid;
    if (userId == null) return Stream.value({});

    return _fireStore
        .collection(FirestoreCollection.userFavorites)
        .doc(userId)
        .snapshots()
        .map((snapshot) {
      final List<dynamic>? favoriteIds =
          snapshot.data()?['itineraries'] as List<dynamic>?;
      return favoriteIds != null
          ? favoriteIds.map((id) => id.toString()).toSet()
          : <String>{};
    });
  }

  @override

  /// Toggles favorite status for an itinerary
  Future<Either<Exception, void>> toggleFavorite({
    required String? itineraryId,
    required bool? isLiked,
  }) async {
    final userId = _firebaseAuth.currentUser?.uid;
    if (userId == null) return Left(Exception('User is not logged in'));

    try {
      final userFavoritesRef =
          _fireStore.collection(FirestoreCollection.userFavorites).doc(userId);

      final docSnapshot = await userFavoritesRef.get();

      if (!docSnapshot.exists) {
        // If document doesn't exist, create it with initial data
        await userFavoritesRef.set({
          'itineraries': isLiked ?? false ? [] : [itineraryId],
        }, SetOptions(merge: true));
      } else {
        // Document exists, update as usual
        await userFavoritesRef.update({
          'itineraries': isLiked ?? false
              ? FieldValue.arrayRemove([itineraryId])
              : FieldValue.arrayUnion([itineraryId])
        });
      }

      return right(null);
    } catch (e) {
      return left(Exception('Failed to toggle favorite: $e'));
    }
  }

  /// ✅ Fetch all collections for the user
  @override
  Future<Either<Exception, List<Collection>>> fetchAllCollections() async {
    try {
      final userId = _firebaseAuth.currentUser?.uid;
      if (userId == null) return left(Exception("User not logged in"));

      final querySnapshot = await _fireStore
          .collection(FirestoreCollection.userFavorites)
          .doc(userId)
          .collection(FirestoreCollection.collections)
          .orderBy('updatedAt', descending: true)
          .get();

      final collections = querySnapshot.docs
          .map((doc) => Collection.fromJson(doc.id, doc.data()))
          .toList();

      return right(collections);
    } catch (e) {
      return left(Exception("Failed to fetch collections: $e"));
    }
  }

  /// ✅ Create a new collection
  @override
  Future<Either<Exception, Collection>> createCollection({
    required String? collectionName,
    required String? imageUrl,
  }) async {
    try {
      final userId = _firebaseAuth.currentUser?.uid;
      if (userId == null) return left(Exception("User not logged in"));

      final collectionRef = _fireStore
          .collection(FirestoreCollection.userFavorites)
          .doc(userId)
          .collection(FirestoreCollection.collections)
          .doc();

      final now = Timestamp.now();

      final newCollection = Collection(
        id: collectionRef.id,
        name: collectionName ?? "Untitled Collection",
        image: imageUrl ?? "",
        itineraries: [],
        createdAt: now,
        updatedAt: now,
      );

      await collectionRef.set(newCollection.toJson());

      return right(newCollection);
    } catch (e) {
      return left(Exception("Failed to create collection: $e"));
    }
  }

  @override

  /// ✅ Delete a collection from Firestore
  Future<Either<Exception, void>> deleteCollection(
      {required String? collectionId}) async {
    try {
      final userId = _firebaseAuth.currentUser?.uid;
      if (userId == null) return left(Exception("User not logged in"));

      final collectionRef = _fireStore
          .collection(FirestoreCollection.userFavorites)
          .doc(userId)
          .collection(FirestoreCollection.collections)
          .doc(collectionId);

      final collectionSnapshot = await collectionRef.get();
      if (!collectionSnapshot.exists) {
        return left(Exception("Collection not found"));
      }

      // ✅ Delete the collection document
      await collectionRef.delete();

      return right(null);
    } catch (e) {
      log("❌ Error deleting collection: $e");
      return left(Exception("Failed to delete collection: $e"));
    }
  }

  /// ✅ Add itinerary to an existing collection
  @override
  Future<Either<Exception, void>> addItineraryToCollection({
    required String? collectionId,
    required String? itineraryId,
    required String? imageUrl,
  }) async {
    try {
      final userId = _firebaseAuth.currentUser?.uid;
      if (userId == null) return left(Exception("User not logged in"));

      final collectionRef = _fireStore
          .collection('user_favorites')
          .doc(userId)
          .collection('collections')
          .doc(collectionId);

      await collectionRef.update({
        'itineraries': FieldValue.arrayUnion([itineraryId]),
        'image': imageUrl,
        'updatedAt': DateTime.now(),
      });

      return right(null);
    } catch (e) {
      return left(Exception("Failed to add itinerary: $e"));
    }
  }

  /// ✅ Remove an itinerary from a collection
  @override
  Future<Either<Exception, void>> removeItineraryFromCollection({
    required String? collectionId,
    required String? itineraryId,
  }) async {
    try {
      final userId = _firebaseAuth.currentUser?.uid;
      if (userId == null) return left(Exception("User not logged in"));

      final collectionRef = _fireStore
          .collection(FirestoreCollection.userFavorites)
          .doc(userId)
          .collection(FirestoreCollection.collections)
          .doc(collectionId);

      // 🔥 Remove itinerary from the collection
      await collectionRef.update({
        'itineraries': FieldValue.arrayRemove([itineraryId]),
        'updatedAt': DateTime.now(),
      });

      return right(null);
    } catch (e) {
      return left(Exception("Failed to remove itinerary from collection: $e"));
    }
  }

  @override

  /// ✅ Fetch itineraries of a collection with optimized pagination & batch fetching
  Future<
      Either<
          Exception,
          ({
            List<TravelItinerary> itineraries,
            DocumentSnapshot? lastDocument,
          })>> fetchItinerariesForCollection({
    required List<String> itineraryIds,
    DocumentSnapshot? lastDocument,
    int limit = 10,
  }) async {
    if (itineraryIds.isEmpty) {
      return right((itineraries: [], lastDocument: null));
    }

    try {
      final List<TravelItinerary> itineraries = [];
      DocumentSnapshot? newLastDocument;

      // 🔥 Firestore allows only 10 values in `whereIn`, so split into batches
      const int batchSize = 10;
      final List<List<String>> batches = [];

      for (int i = 0; i < itineraryIds.length; i += batchSize) {
        batches.add(itineraryIds.sublist(
            i,
            i + batchSize > itineraryIds.length
                ? itineraryIds.length
                : i + batchSize));
      }

      // ✅ Fetch all itinerary documents **in parallel**
      final List<Future<QuerySnapshot<Map<String, dynamic>>>> queries =
          batches.map((batch) {
        Query<Map<String, dynamic>> query = _fireStore
            .collection(FirestoreCollection.itineraries)
            .where(FieldPath.documentId, whereIn: batch)
            .orderBy('createdAt', descending: true)
            .limit(limit);

        if (lastDocument != null) {
          query = query.startAfterDocument(lastDocument);
        }

        return query.get();
      }).toList();

      final List<QuerySnapshot<Map<String, dynamic>>> querySnapshots =
          await Future.wait(queries);

      // Extract all documents into a list
      final List<QueryDocumentSnapshot<Map<String, dynamic>>> allDocs =
          querySnapshots.expand((q) => q.docs).toList();

      // ✅ Track last document only if enough results were fetched
      if (allDocs.length == limit) {
        newLastDocument = allDocs.last;
      }

      // ✅ Check if no itineraries are found
      if (allDocs.isEmpty) {
        return right((itineraries: [], lastDocument: null));
      }

      // 🔥 Fetch Days & Activities for all itineraries **in parallel**
      final List<TravelItinerary> fetchedItineraries =
          await fetchDaysAndActivitiesParallel(
        queryDocs: allDocs, // ✅ Uses flexible function
        auth: _firebaseAuth,
        firestore: _fireStore,
      );

      itineraries.addAll(fetchedItineraries);

      return right((itineraries: itineraries, lastDocument: newLastDocument));
    } catch (e) {
      log("❌ Error fetching collection itineraries: $e");
      return left(Exception("Failed to fetch itineraries for collection: $e"));
    }
  }
}
