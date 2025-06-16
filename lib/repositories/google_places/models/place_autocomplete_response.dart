import 'package:json_annotation/json_annotation.dart';
import 'package:travel_hero/repositories/google_places/models/structured_formatting.dart';

part 'place_autocomplete_response.g.dart';

@JsonSerializable()
class PlaceAutocompleteResponse {
  final List<Prediction> predictions;

  PlaceAutocompleteResponse({required this.predictions});

  factory PlaceAutocompleteResponse.fromJson(Map<String, dynamic> json) =>
      _$PlaceAutocompleteResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceAutocompleteResponseToJson(this);
}

@JsonSerializable()
class Prediction {
  final String description;
  final String place_id;
  @JsonKey(name: 'structured_formatting') // Map JSON key to class field
  final StructuredFormatting structuredFormatting;
  Prediction({required this.description, required this.place_id,required this.structuredFormatting,});

  factory Prediction.fromJson(Map<String, dynamic> json) =>
      _$PredictionFromJson(json);

  Map<String, dynamic> toJson() => _$PredictionToJson(this);
}
