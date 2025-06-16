// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceDetailsResponse _$PlaceDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    PlaceDetailsResponse(
      result: Result.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlaceDetailsResponseToJson(
        PlaceDetailsResponse instance) =>
    <String, dynamic>{
      'result': instance.result,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      photos: (json['photos'] as List<dynamic>?)
          ?.map((e) => Photo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'photos': instance.photos,
    };

Photo _$PhotoFromJson(Map<String, dynamic> json) => Photo(
      photoReference: json['photo_reference'] as String,
    );

Map<String, dynamic> _$PhotoToJson(Photo instance) => <String, dynamic>{
      'photo_reference': instance.photoReference,
    };
