import 'package:hive/hive.dart';
import 'package:travel_hero/src/domain/itinerary/activity.dart';
import 'package:travel_hero/src/infrastructure/utils/constants.dart';
import 'package:widgets_book/widgets_book.dart';
part 'day_plan.g.dart';

@HiveType(typeId: HiveConstants.dayPlanTypeId)
@JsonSerializable(
  includeIfNull: false,
)
class DayPlan {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? itineraryId;
  @HiveField(2)
  final int day;
  @HiveField(3)
  final String date;
  @HiveField(4)
  final String title;
  @HiveField(5)
  @JsonKey(includeToJson: false, defaultValue: [])
  @HiveField(6)
  final List<Activity> activities;
  @HiveField(7)
  final DateTime? createdAt;
  @HiveField(8)
  final DateTime? updatedAt;

  DayPlan({
    this.id,
    this.itineraryId,
    required this.day,
    required this.title,
    required this.date,
    required this.activities,
    this.createdAt,
    this.updatedAt,
  });
// CopyWith method
  DayPlan copyWith({
    String? id,
    String? itineraryId,
    int? day,
    String? title,
    String? date,
    List<Activity>? activities,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DayPlan(
      id: id ?? this.id,
      itineraryId: itineraryId ?? this.itineraryId,
      day: day ?? this.day,
      title: title ?? this.title,
      date: date ?? this.date,
      activities: activities ?? this.activities,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory DayPlan.fromJson(Map<String, dynamic> json) =>
      _$DayPlanFromJson(json);

  Map<String, dynamic> toJson() => _$DayPlanToJson(this);
}
