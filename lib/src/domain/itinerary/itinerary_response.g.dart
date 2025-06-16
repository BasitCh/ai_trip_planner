// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'itinerary_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItineraryResponse _$ItineraryResponseFromJson(Map<String, dynamic> json) =>
    ItineraryResponse(
      valid: json['valid'] as bool?,
      message: json['message'] as String?,
      travelItinerary: json['travel_itinerary'] == null
          ? null
          : TravelItinerary.fromJson(
              json['travel_itinerary'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ItineraryResponseToJson(ItineraryResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('valid', instance.valid);
  writeNotNull('message', instance.message);
  writeNotNull('travel_itinerary', instance.travelItinerary?.toJson());
  return val;
}
