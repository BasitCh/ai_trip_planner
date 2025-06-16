import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fpdart/fpdart.dart';
import 'package:travel_hero/global/pair.dart';
import 'package:travel_hero/src/domain/itinerary/i_travel_itinerary_repository.dart';
import 'package:travel_hero/src/domain/itinerary/itinerary_request.dart';
import 'package:travel_hero/src/domain/itinerary/itinerary_request_body.dart';
import 'package:travel_hero/src/domain/itinerary/itinerary_response.dart';
import 'package:travel_hero/src/domain/itinerary/travel_itinerary.dart';
import 'package:travel_hero/src/infrastructure/itinerary/itinerary_service.dart';
import 'package:widgets_book/widgets_book.dart';

int requestsPageLimit = 10;

class ItineraryRepository extends ITravelItineraryRepository {
  final ItineraryService itineraryService;
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  ItineraryRepository({
    required this.itineraryService,
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });

  @override
  Future<Either<Exception, ItineraryResponse>> generateItinerary({
    required ItineraryRequestBody itineraryRequestBody,
  }) async {
    try {
      final String openAiKey = dotenv.env['OPEN_AI_API_KEY'] ?? '';
      final response = await itineraryService.getItineraryFromAi(
        authorization: 'Bearer $openAiKey',
        itineraryRequestBody: itineraryRequestBody,
      );
      final content = response.choices[0].message.content;
      // Parse the JSON content from OpenAI's response
      final jsonStartIndex = content.indexOf('{');
      final jsonEndIndex = content.lastIndexOf('}');
      if (jsonStartIndex == -1 ||
          jsonEndIndex == -1 ||
          jsonEndIndex <= jsonStartIndex) {
        return Left(Exception('No JSON object found in the response'));
      }
      final validJsonString =
          content.substring(jsonStartIndex, jsonEndIndex + 1).trim();

      log(validJsonString);
      final decodedJson = json.decode(validJsonString);
      if (decodedJson['valid'] == false) {
        return left(Exception(
            decodedJson['message'] ?? 'Failed to generate itinerary'));
      } else {
        final itineraryResponse = ItineraryResponse.fromJson(decodedJson);
        return (Right(itineraryResponse));
      }
    } on DioException catch (_) {
      return left(Exception('Failed to generate itinerary'));
    }
  }

  @override
  Future<Either<Exception, TravelItinerary>> saveItinerary(
      {required String? uid, required TravelItinerary travelItinerary}) async {
    if (uid == null || uid.isEmpty) {
      return left(Exception('User is not logged in'));
    }

    // Reference to the itineraries collection
    final itineraryRef =
        firebaseFirestore.collection(FirestoreCollection.itineraries).doc();
    final daysRef = itineraryRef.collection(FirestoreCollection.days);

    try {
      final itineraryId = itineraryRef.id;

      for (final day in travelItinerary.dayPlans) {
        final dayDoc = daysRef.doc();
        final dayId = dayDoc.id;
        final activitiesRef = dayDoc.collection(FirestoreCollection.activities);

        for (final activity in day.activities) {
          final activityDoc = activitiesRef.doc();
          final activityId = activityDoc.id;

          // Save activity
          await activityDoc.set(activity
              .copyWith(
                id: activityId,
                dayId: dayId,
                itineraryId: itineraryId,
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
              )
              .toJson());
        }

        // Save day
        await dayDoc.set(day
            .copyWith(
              id: dayId,
              itineraryId: itineraryId,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            )
            .toJson());
      }

      // Save itinerary with global structure
      final updatedItinerary = travelItinerary.copyWith(
        id: itineraryId,
        userId: uid,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await itineraryRef.set(updatedItinerary.toJson());

      return Right(updatedItinerary);
    } catch (e) {
      return Left(Exception("Failed to save itinerary: $e"));
    }
  }

  @override
  Future<Either<Exception, TravelItinerary>> updateItinerary(
      {required TravelItinerary travelItinerary}) async {
    final uid = firebaseAuth.currentUser?.uid;
    if (uid == null || uid.isEmpty) {
      return left(Exception('User is not logged in'));
    }

    // Reference to the itineraries collection
    final itineraryRef = firebaseFirestore
        .collection(FirestoreCollection.itineraries)
        .doc(travelItinerary.id);
    final daysRef = itineraryRef.collection(FirestoreCollection.days);

    try {
      final updatedItinerary = travelItinerary.copyWith(
        updatedAt: DateTime.now(),
      );
      await itineraryRef.update(updatedItinerary.toJson());

      for (final day in travelItinerary.dayPlans) {
        final dayDoc = daysRef.doc(day.id);
        final activitiesRef = dayDoc.collection(FirestoreCollection.activities);

        // Check if the day document exists
        final dayDocSnapshot = await dayDoc.get();
        if (dayDocSnapshot.exists) {
          // Update the existing day
          await dayDoc.update(
            day.copyWith(updatedAt: DateTime.now()).toJson(),
          );
        } else {
          // If the day does not exist, create it
          await dayDoc.set(day
              .copyWith(
                itineraryId: travelItinerary.id,
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
              )
              .toJson());
        }

        // Iterate through the activities for the day
        for (final activity in day.activities) {
          final activityDoc = activitiesRef.doc(activity.id);

          // Check if the activity document exists
          final activityDocSnapshot = await activityDoc.get();
          if (activityDocSnapshot.exists) {
            // Update the existing activity
            await activityDoc.update(
              activity.copyWith(updatedAt: DateTime.now()).toJson(),
            );
          } else {
            // Create the activity if it doesn't exist
            await activityDoc.set(activity
                .copyWith(
                  dayId: day.id,
                  itineraryId: travelItinerary.id,
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                )
                .toJson());
          }
        }
      }

      // Return the updated itinerary
      return Right(updatedItinerary);
    } catch (e) {
      return Left(Exception("Failed to update itinerary: $e"));
    }
  }

  @override
  Future<Either<Exception, void>> unlockItinerary(
      {required String? itineraryId}) async {
    final uid = firebaseAuth.currentUser?.uid;
    if (uid == null || uid.isEmpty) {
      return left(Exception('User is not logged in'));
    }
    try {
      final itineraryRef = firebaseFirestore
          .collection(FirestoreCollection.itineraries)
          .doc(itineraryId);

      await itineraryRef.update({
        'unlockedBy': FieldValue.arrayUnion(
            [uid]), // Add the user to the unlockedBy array
      });

      return right(null);
    } catch (e) {
      return left(Exception('Failed to unlock itinerary: $e'));
    }
  }

  @override
  Future<Either<Exception, ItineraryRequest>> submitTripRequest(
      {required ItineraryRequest request}) async {
    try {
      final currentUser = firebaseAuth.currentUser;
      final uid = currentUser?.uid;
      if (uid == null) {
        return Left(Exception('User not authenticated'));
      }

      final docRef = firebaseFirestore
          .collection(FirestoreCollection.itineraryRequests)
          .doc();

      final updatedRequest = request.copyWith(
        id: docRef.id,
        travellerId: uid,
        travellerName: currentUser?.displayName,
        travellerProfileUrl: currentUser?.photoURL,
        createdAt: Timestamp.now(),
        isRead: false,
      );

      await docRef.set(updatedRequest.toJson());
      return Right(updatedRequest);
    } catch (e) {
      return Left(Exception('Failed to submit request: $e'));
    }
  }

  @override
  Future<int> fetchUnreadRequestCount() async {
    final uid = firebaseAuth.currentUser?.uid;
    //'4xiSZvuTWtTCIYNMxqrGMoXhd3i2'; 'mMTqgYl513R2nPNGgYyEf3h6fU93';
    if (uid == null) {
      return 0;
    }

    QuerySnapshot snapshot = await firebaseFirestore
        .collection(FirestoreCollection.itineraryRequests)
        .where('travelHeroId', isEqualTo: uid)
        .where('isRead', isEqualTo: false)
        .get();

    return snapshot.size;
  }

  @override
  Stream<Pair<List<ItineraryRequest>, DocumentSnapshot?>> watchRequests({
    DocumentSnapshot? lastDocument,
  }) {
    final uid = firebaseAuth.currentUser?.uid;
    //'4xiSZvuTWtTCIYNMxqrGMoXhd3i2'; 'mMTqgYl513R2nPNGgYyEf3h6fU93';
    if (uid == null) {
      return Stream.value(
          Pair([], null)); // Return an empty stream if no user is logged in
    }

    Query query = firebaseFirestore
        .collection(FirestoreCollection.itineraryRequests)
        .where('travelHeroId', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .limit(10); // Pagination limit

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    return query.snapshots().map((snapshot) {
      final requests = snapshot.docs.map((doc) {
        return ItineraryRequest.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      DocumentSnapshot? lastDoc = snapshot.docs.isNotEmpty
          ? snapshot.docs.last // Store last document for pagination
          : null;

      return Pair(requests, lastDoc);
    });
  }

  @override
  Future<Either<Exception, void>> updateRequest(
      {required ItineraryRequest request}) async {
    try {
      await firebaseFirestore
          .collection(FirestoreCollection.itineraryRequests)
          .doc(request.id)
          .update(request.toJson());
      return Right(null);
    } catch (e) {
      return Left(Exception('Failed to update request: $e'));
    }
  }

  @override
  Stream<Pair<List<ItineraryRequest>, DocumentSnapshot<Object?>?>>
      watchInProgressRequests({DocumentSnapshot<Object?>? lastDocument}) {
    final uid = firebaseAuth.currentUser?.uid;
    if (uid == null) {
      return Stream.value(
          Pair([], null)); // Return an empty stream if no user is logged in
    }

    Query query = firebaseFirestore
        .collection(FirestoreCollection.itineraryRequests)
        .where('travellerId', isEqualTo: uid)
        .where('status', isEqualTo: 'pending')
        .orderBy('createdAt', descending: true)
        .limit(10); // Pagination limit

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    return query.snapshots().map((snapshot) {
      final requests = snapshot.docs.map((doc) {
        return ItineraryRequest.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      DocumentSnapshot? lastDoc = snapshot.docs.isNotEmpty
          ? snapshot.docs.last // Store last document for pagination
          : null;

      return Pair(requests, lastDoc);
    });
  }

  @override
  Future<Pair<List<ItineraryRequest>, DocumentSnapshot?>>
      fetchInProgressRequests({
    required DocumentSnapshot lastDocument,
  }) async {
    final uid = firebaseAuth.currentUser?.uid;
    if (uid == null) {
      return Pair([], null);
    }

    try {
      Query query = firebaseFirestore
          .collection(FirestoreCollection.itineraryRequests)
          .where('travellerId', isEqualTo: uid)
          .where('status', isEqualTo: 'pending')
          .orderBy('createdAt', descending: true)
          .startAfterDocument(lastDocument)
          .limit(requestsPageLimit);

      final snapshot = await query.get();

      final requests = snapshot.docs.map((doc) {
        return ItineraryRequest.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      final lastDoc = snapshot.docs.isNotEmpty ? snapshot.docs.last : null;

      return Pair(requests, lastDoc);
    } catch (e) {
      return Pair([], null); // Optional: You might want to throw or log instead
    }
  }
}
