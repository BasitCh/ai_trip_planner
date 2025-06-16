// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'itinerary_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItineraryRequestBody _$ItineraryRequestBodyFromJson(
        Map<String, dynamic> json) =>
    ItineraryRequestBody(
      model: json['model'] as String,
      messages: (json['messages'] as List<dynamic>)
          .map((e) => AiRequestMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
      maxTokens: (json['max_tokens'] as num?)?.toInt() ?? 2000,
    );

Map<String, dynamic> _$ItineraryRequestBodyToJson(
        ItineraryRequestBody instance) =>
    <String, dynamic>{
      'model': instance.model,
      'messages': instance.messages.map((e) => e.toJson()).toList(),
      'max_tokens': instance.maxTokens,
    };
