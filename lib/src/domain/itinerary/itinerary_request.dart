import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:widgets_book/widgets_book.dart';

part 'itinerary_request.g.dart';

@JsonSerializable()
class ItineraryRequest {
  final String? id;
  final String travellerId;
  final String? travellerName;
  final String? travellerProfileUrl;
  final String? placeName;
  final String? placeImage;
  final String? placeDescription;
  final int? people;
  final int? duration;
  final String? mood;
  @JsonKey(fromJson: dateFromJson, toJson: dateToJson)
  final Timestamp? startDate;
  @JsonKey(fromJson: dateFromJson, toJson: dateToJson)
  final Timestamp? endDate;
  final String? selectedMonth;
  final String? status;
  @JsonKey(fromJson: dateFromJson, toJson: dateToJson)
  final Timestamp? createdAt;
  final String? travelHeroId;
  final String? travelHeroName;
  final String? travelHeroProfileUrl;
  @JsonKey(defaultValue: false)
  final bool? isRead;
  final String? declinedReason;
  final String? dateSelectionMethod;

  ItineraryRequest({
    required this.id,
    required this.travellerId,
    required this.travellerName,
    required this.placeName,
    required this.placeImage,
    required this.placeDescription,
    required this.people,
    required this.duration,
    required this.mood,
    required this.startDate,
    required this.endDate,
    required this.selectedMonth,
    required this.status,
    required this.createdAt,
    required this.dateSelectionMethod,
    required this.travelHeroId,
    required this.travelHeroName,
    required this.travelHeroProfileUrl,
    required this.isRead,
    this.declinedReason,
    this.travellerProfileUrl,
  });

  ItineraryRequest copyWith(
      {String? id,
      String? travellerId,
      String? travellerName,
      String? placeName,
      String? placeImage,
      String? placeDescription,
      int? people,
      int? duration,
      String? mood,
      Timestamp? startDate,
      Timestamp? endDate,
      String? selectedMonth,
      String? status,
      Timestamp? createdAt,
      String? travelHeroId,
      String? travelHeroName,
      String? travelHeroProfileUrl,
      bool? isRead,
      String? declinedReason,
      String? travellerProfileUrl,
      String? dateSelectionMethod}) {
    return ItineraryRequest(
      id: id ?? this.id,
      travellerId: travellerId ?? this.travellerId,
      travellerName: travellerName ?? this.travellerName,
      placeName: placeName ?? this.placeName,
      placeImage: placeImage ?? this.placeImage,
      placeDescription: placeDescription ?? this.placeDescription,
      people: people ?? this.people,
      duration: duration ?? this.duration,
      mood: mood ?? this.mood,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      selectedMonth: selectedMonth ?? this.selectedMonth,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      travelHeroId: travelHeroId ?? this.travelHeroId,
      travelHeroName: travelHeroName ?? this.travelHeroName,
      travelHeroProfileUrl: travelHeroProfileUrl ?? this.travelHeroProfileUrl,
      isRead: isRead ?? this.isRead,
      declinedReason: declinedReason ?? this.declinedReason,
      travellerProfileUrl: travellerProfileUrl ?? this.travellerProfileUrl,
      dateSelectionMethod: dateSelectionMethod ?? this.dateSelectionMethod,
    );
  }

  factory ItineraryRequest.fromJson(Map<String, dynamic> json) =>
      _$ItineraryRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ItineraryRequestToJson(this);
}
