// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'itinerary_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItineraryRequest _$ItineraryRequestFromJson(Map<String, dynamic> json) =>
    ItineraryRequest(
      id: json['id'] as String?,
      travellerId: json['travellerId'] as String,
      travellerName: json['travellerName'] as String?,
      placeName: json['placeName'] as String?,
      placeImage: json['placeImage'] as String?,
      placeDescription: json['placeDescription'] as String?,
      people: (json['people'] as num?)?.toInt(),
      duration: (json['duration'] as num?)?.toInt(),
      mood: json['mood'] as String?,
      startDate: dateFromJson(json['startDate'] as Timestamp?),
      endDate: dateFromJson(json['endDate'] as Timestamp?),
      selectedMonth: json['selectedMonth'] as String?,
      status: json['status'] as String?,
      createdAt: dateFromJson(json['createdAt'] as Timestamp?),
      dateSelectionMethod: json['dateSelectionMethod'] as String?,
      travelHeroId: json['travelHeroId'] as String?,
      travelHeroName: json['travelHeroName'] as String?,
      travelHeroProfileUrl: json['travelHeroProfileUrl'] as String?,
      isRead: json['isRead'] as bool? ?? false,
      declinedReason: json['declinedReason'] as String?,
      travellerProfileUrl: json['travellerProfileUrl'] as String?,
    );

Map<String, dynamic> _$ItineraryRequestToJson(ItineraryRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'travellerId': instance.travellerId,
      'travellerName': instance.travellerName,
      'travellerProfileUrl': instance.travellerProfileUrl,
      'placeName': instance.placeName,
      'placeImage': instance.placeImage,
      'placeDescription': instance.placeDescription,
      'people': instance.people,
      'duration': instance.duration,
      'mood': instance.mood,
      'startDate': dateToJson(instance.startDate),
      'endDate': dateToJson(instance.endDate),
      'selectedMonth': instance.selectedMonth,
      'status': instance.status,
      'createdAt': dateToJson(instance.createdAt),
      'travelHeroId': instance.travelHeroId,
      'travelHeroName': instance.travelHeroName,
      'travelHeroProfileUrl': instance.travelHeroProfileUrl,
      'isRead': instance.isRead,
      'declinedReason': instance.declinedReason,
      'dateSelectionMethod': instance.dateSelectionMethod,
    };
