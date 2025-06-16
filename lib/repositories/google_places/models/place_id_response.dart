import 'package:json_annotation/json_annotation.dart';

part 'place_id_response.g.dart';

@JsonSerializable()
class PlaceIdResponse {
  final List<Candidate> candidates;

  PlaceIdResponse({required this.candidates});

  factory PlaceIdResponse.fromJson(Map<String, dynamic> json) =>
      _$PlaceIdResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceIdResponseToJson(this);
}

@JsonSerializable()
class Candidate {
  final String place_id;

  Candidate({required this.place_id});

  factory Candidate.fromJson(Map<String, dynamic> json) =>
      _$CandidateFromJson(json);

  Map<String, dynamic> toJson() => _$CandidateToJson(this);
}
