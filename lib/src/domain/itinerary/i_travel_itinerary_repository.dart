// itinerary_repository.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:travel_hero/global/pair.dart';
import 'package:travel_hero/src/domain/itinerary/itinerary_request.dart';
import 'package:travel_hero/src/domain/itinerary/itinerary_request_body.dart';
import 'package:travel_hero/src/domain/itinerary/itinerary_response.dart';
import 'package:travel_hero/src/domain/itinerary/travel_itinerary.dart';

abstract class ITravelItineraryRepository {
  Future<Either<Exception, ItineraryResponse>> generateItinerary({
    required ItineraryRequestBody itineraryRequestBody,
  });

  Future<Either<Exception, TravelItinerary>> saveItinerary({
    required String? uid,
    required TravelItinerary travelItinerary,
  });

  Future<Either<Exception, TravelItinerary>> updateItinerary(
      {required TravelItinerary travelItinerary});

  Future<Either<Exception, void>> unlockItinerary(
      {required String? itineraryId});

  Future<Either<Exception, ItineraryRequest>> submitTripRequest({
    required ItineraryRequest request,
  });

  Future<int> fetchUnreadRequestCount();

  Stream<Pair<List<ItineraryRequest>, DocumentSnapshot?>> watchRequests(
      {DocumentSnapshot? lastDocument});

  Stream<Pair<List<ItineraryRequest>, DocumentSnapshot?>>
      watchInProgressRequests({DocumentSnapshot? lastDocument});

  Future<Pair<List<ItineraryRequest>, DocumentSnapshot?>>
      fetchInProgressRequests({
    required DocumentSnapshot lastDocument,
  });

  Future<Either<Exception, void>> updateRequest(
      {required ItineraryRequest request});
}
