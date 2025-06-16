import 'package:travel_hero/repositories/google_places/models/place_autocomplete_response.dart';

import 'google_places_service.dart';

class GooglePlacesRepository {
  final GooglePlacesService googlePlacesService;
  final String apiKey;

  GooglePlacesRepository(this.googlePlacesService, this.apiKey);

  Future<List<Prediction>> searchPlaces(String query,
      [String? isoCountry]) async {
    if (query.isEmpty) return [];

    try {
      final components = isoCountry != null ? "country:$isoCountry" : "";
      final response = await googlePlacesService.searchPlaces(
        query,
        apiKey,
        components,
      );
      return response
          .predictions; // This now correctly returns the predictions.
    } catch (e) {
      throw Exception("Error fetching places: $e");
    }
  }


// Fetch Place ID from a query
  Future<String?> fetchPlaceId(String query,) async {
    try {
      final response = await googlePlacesService.getPlaceId(
        query,
        "textquery",
        "place_id",
        apiKey,
      );

      if (response.candidates.isEmpty) {
        throw Exception("No place found for query: $query");
      }

      return response.candidates[0].place_id;
    } catch (e) {
      throw Exception("Error fetching place ID: $e");
    }
  }

  // Fetch multiple images using Place ID
  Future<List<String>> fetchMultipleImages(String query) async {
    try {
      // Fetch Place ID
      final placeId = await fetchPlaceId(query);
      if (placeId == null) {
        throw Exception("Place ID not found for query: $query");
      }

      // Fetch photo references
      final placeDetailsResponse = await googlePlacesService.getPlaceDetails(
        placeId,
        "photos",
        apiKey,
      );

      final photos = placeDetailsResponse.result.photos;
      if (photos == null || photos.isEmpty) {
        throw Exception("No photos available for place ID: $placeId");
      }

      // Generate URLs for the first 3–4 photos
      final photoUrls = photos.take(4).map((photo) {
        return 'https://maps.googleapis.com/maps/api/place/photo'
            '?maxwidth=800'
            '&photoreference=${photo.photoReference}'
            '&key=$apiKey';
      }).toList();

      return photoUrls;
    } catch (e) {
      return [];
    }
  }

  // Fetch multiple images using Place ID
  Future<String?> fetchSingleImage(String query) async {
    try {

      // Fetch Place ID
      // final placeId = await fetchPlaceId(query);
      // if (placeId == null) {
      //   throw Exception("Place ID not found for query: $query");
      // }
      // print("fetchSingleImage ${placeId}");
      // Fetch photo references
      final placeDetailsResponse = await googlePlacesService.getPlaceDetails(
        query,
        "photos",
        apiKey,
      );
      print('photos!.first.photoReference${placeDetailsResponse.result.photos!.first.photoReference}');
      final photos = placeDetailsResponse.result.photos;

      if (photos == null || photos.isEmpty) {

        throw Exception("No photos available for place ID: $query");
      }
      print("https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${photos.first.photoReference}&key=$apiKey");

      // Generate URLs for the first 3–4 photos
        return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${photos.first.photoReference}&key=$apiKey";


    } catch (e) {
      print('photos!.first.photoReferenceerror');
      return '';
    }
  }
}
