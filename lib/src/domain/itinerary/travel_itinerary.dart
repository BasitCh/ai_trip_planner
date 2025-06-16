import 'package:hive/hive.dart';
import 'package:travel_hero/src/domain/itinerary/day_plan.dart';
import 'package:travel_hero/src/domain/itinerary/visibility.dart';
import 'package:travel_hero/src/infrastructure/utils/constants.dart';
import 'package:widgets_book/widgets_book.dart';

part 'travel_itinerary.g.dart';

@HiveType(typeId: HiveConstants.itineraryTypeId)
@JsonSerializable(
  includeIfNull: false,
  explicitToJson: true,
)
class TravelItinerary {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? trip;
  @HiveField(2)
  final String? createdBy;
  @HiveField(3)
  final String? profileUrl;
  @HiveField(4)
  final String? duration;
  @HiveField(5)
  final String? destination;
  @HiveField(6)
  final String? description;
  @HiveField(7)
  final double? price;
  @HiveField(8)
  final String? currency;
  @HiveField(9)
  final String? symbol;
  @HiveField(10)
  @JsonKey(name: 'itinerary', includeToJson: false, defaultValue: [])
  final List<DayPlan> dayPlans;
  @HiveField(11)
  @JsonKey(name: "isPaidPlan")
  final bool isPaidPlan;
  @HiveField(12)
  final double? rating;
  @HiveField(13)
  final int? reviewCount;
  @HiveField(14)
  final bool? isLiked;
  @HiveField(15)
  final DateTime? createdAt;
  @HiveField(16)
  final DateTime? updatedAt;
  @HiveField(17)
  final String? userId;
  @HiveField(18)
  final List<String>? unlockedBy;
  @HiveField(19)
  @JsonKey(includeFromJson: false, includeToJson: false)
  final bool? isUnlockedForCurrentUser;
  @HiveField(20)
  @JsonKey(defaultValue: false)
  final bool? isRequestedItinerary;
  @HiveField(21)
  final String? linkedRequestId;
  @HiveField(22)
  final TravelVisibility? visibility;
  @HiveField(23)
  final String? mood;
  @HiveField(24)
  final List<dynamic>? coverUrls;

  TravelItinerary({
    this.id,
    this.trip,
    this.createdBy,
    this.profileUrl,
    this.duration,
    this.destination,
    this.description,
    this.price,
    this.currency,
    this.symbol,
    required this.dayPlans,
    this.isRequestedItinerary,
    this.isPaidPlan = false,
    this.rating = 0,
    this.reviewCount,
    this.isLiked,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.unlockedBy = const <String>[],
    this.isUnlockedForCurrentUser = false,
    this.linkedRequestId,
    this.visibility,
    this.mood,
    this.coverUrls = const <String>[],
  });

  // CopyWith method
  TravelItinerary copyWith({
    String? id,
    String? trip,
    String? createdBy,
    String? profileUrl,
    String? duration,
    String? destination,
    String? description,
    double? price,
    String? currency,
    String? symbol,
    List<DayPlan>? dayPlans,
    bool? isPaidPlan,
    double? rating,
    int? reviewCount,
    bool? isLiked,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? userId,
    List<String>? unlockedBy,
    bool? isUnlockedForCurrentUser,
    bool? isRequestedItinerary,
    String? linkedRequestId,
    TravelVisibility? visibility,
    String? mood,
    List<dynamic>? coverUrls,
  }) {
    return TravelItinerary(
      id: id ?? this.id,
      trip: trip ?? this.trip,
      createdBy: createdBy ?? this.createdBy,
      profileUrl: profileUrl ?? this.profileUrl,
      duration: duration ?? this.duration,
      destination: destination ?? this.destination,
      description: description ?? this.description,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      symbol: symbol ?? this.symbol,
      dayPlans: dayPlans ?? this.dayPlans,
      isPaidPlan: isPaidPlan ?? this.isPaidPlan,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      isLiked: isLiked ?? this.isLiked,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
      unlockedBy: unlockedBy ?? this.unlockedBy,
      isUnlockedForCurrentUser:
          isUnlockedForCurrentUser ?? this.isUnlockedForCurrentUser,
      isRequestedItinerary: isRequestedItinerary ?? this.isRequestedItinerary,
      linkedRequestId: linkedRequestId ?? this.linkedRequestId,
      visibility: visibility ?? this.visibility,
      mood: mood ?? this.mood,
      coverUrls: coverUrls ?? this.coverUrls,
    );
  }

  factory TravelItinerary.fromJson(Map<String, dynamic> json) =>
      _$TravelItineraryFromJson(json);

  Map<String, dynamic> toJson() => _$TravelItineraryToJson(this);
}
