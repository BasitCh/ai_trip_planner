import 'package:json_annotation/json_annotation.dart';
part 'place_details_response.g.dart';

@JsonSerializable()
class PlaceDetailsResponse {
  final Result result;

  PlaceDetailsResponse({required this.result});

  factory PlaceDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$PlaceDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceDetailsResponseToJson(this);
}

@JsonSerializable()
class Result {
  final List<Photo>? photos;

  Result({this.photos});

  factory Result.fromJson(Map<String, dynamic> json) =>
      _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

@JsonSerializable()
class Photo {
  @JsonKey(name: "photo_reference")
  final String photoReference;

  Photo({required this.photoReference});

  factory Photo.fromJson(Map<String, dynamic> json) =>
      _$PhotoFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoToJson(this);
}
