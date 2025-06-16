import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:travel_hero/src/domain/favorites/collection.dart';
import 'package:travel_hero/src/domain/itinerary/travel_itinerary.dart';

abstract class IFavoritesItineraryRepository {
  Stream<Set<String>> watchUserFavorites();

  Future<Either<Exception, void>> toggleFavorite(
      {required String? itineraryId, required bool? isLiked});

  Future<Either<Exception, List<Collection>>> fetchAllCollections();

  Future<Either<Exception, Collection>> createCollection({
    required String? collectionName,
    required String? imageUrl,
  });

  Future<Either<Exception, void>> deleteCollection(
      {required String? collectionId});

  Future<Either<Exception, void>> addItineraryToCollection({
    required String? collectionId,
    required String? itineraryId,
    required String? imageUrl,
  });

  Future<Either<Exception, void>> removeItineraryFromCollection({
    required String? collectionId,
    required String? itineraryId,
  });

  Future<
      Either<
          Exception,
          ({
            List<TravelItinerary> itineraries,
            DocumentSnapshot? lastDocument
          })>> fetchItinerariesForCollection({
    required List<String> itineraryIds,
    DocumentSnapshot? lastDocument,
    int limit,
  });
}
