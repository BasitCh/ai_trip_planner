// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_autocomplete_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceAutocompleteResponse _$PlaceAutocompleteResponseFromJson(
        Map<String, dynamic> json) =>
    PlaceAutocompleteResponse(
      predictions: (json['predictions'] as List<dynamic>)
          .map((e) => Prediction.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlaceAutocompleteResponseToJson(
        PlaceAutocompleteResponse instance) =>
    <String, dynamic>{
      'predictions': instance.predictions,
    };

Prediction _$PredictionFromJson(Map<String, dynamic> json) => Prediction(
      description: json['description'] as String,
      place_id: json['place_id'] as String,
      structuredFormatting: StructuredFormatting.fromJson(
          json['structured_formatting'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PredictionToJson(Prediction instance) =>
    <String, dynamic>{
      'description': instance.description,
      'place_id': instance.place_id,
      'structured_formatting': instance.structuredFormatting,
    };
