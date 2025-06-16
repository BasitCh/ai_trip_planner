// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_id_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceIdResponse _$PlaceIdResponseFromJson(Map<String, dynamic> json) =>
    PlaceIdResponse(
      candidates: (json['candidates'] as List<dynamic>)
          .map((e) => Candidate.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlaceIdResponseToJson(PlaceIdResponse instance) =>
    <String, dynamic>{
      'candidates': instance.candidates,
    };

Candidate _$CandidateFromJson(Map<String, dynamic> json) => Candidate(
      place_id: json['place_id'] as String,
    );

Map<String, dynamic> _$CandidateToJson(Candidate instance) => <String, dynamic>{
      'place_id': instance.place_id,
    };
