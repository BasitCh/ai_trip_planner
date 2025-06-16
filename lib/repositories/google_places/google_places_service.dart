import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:travel_hero/repositories/google_places/models/place_autocomplete_response.dart';
import 'package:travel_hero/repositories/google_places/models/place_details_response.dart';
import 'package:travel_hero/repositories/google_places/models/place_id_response.dart';

part 'google_places_service.g.dart'; // Run build_runner to generate this file

@RestApi(baseUrl: "https://maps.googleapis.com/maps/api/place")
abstract class GooglePlacesService {
  factory GooglePlacesService(Dio dio, {String baseUrl}) = _GooglePlacesService;

  @GET("/autocomplete/json")
  Future<PlaceAutocompleteResponse> searchPlaces(
    @Query("input") String query,
    @Query("key") String apiKey,
    @Query("components") String components,
  );

  @GET("/findplacefromtext/json")
  Future<PlaceIdResponse> getPlaceId(
    @Query("input") String query,
    @Query("inputtype") String inputType,
    @Query("fields") String fields,
    @Query("key") String apiKey,
  );

  @GET("/details/json")
  Future<PlaceDetailsResponse> getPlaceDetails(
    @Query("place_id") String placeId,
    @Query("fields") String fields,
    @Query("key") String apiKey,
  );
}
