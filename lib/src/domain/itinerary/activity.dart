import 'package:hive/hive.dart';
import 'package:travel_hero/src/domain/itinerary/coordinates.dart';
import 'package:travel_hero/src/infrastructure/utils/constants.dart';
import 'package:widgets_book/widgets_book.dart';
part 'activity.g.dart';

@HiveType(typeId: HiveConstants.activityTypeId)
@JsonSerializable(
  includeIfNull: false,
  explicitToJson: true,
)
class Activity {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? dayId;
  @HiveField(2)
  final String? itineraryId;
  @HiveField(3)
  final String name;
  @HiveField(4)
  final String description;
  @HiveField(5)
  final String address;
  @HiveField(6)
  final Coordinates coordinates;
  @HiveField(7)
  @JsonKey(defaultValue: [])
  List<dynamic> images;
  @HiveField(8)
  final DateTime? createdAt;
  @HiveField(9)
  final DateTime? updatedAt;

  Activity({
    this.id,
    this.dayId,
    this.itineraryId,
    required this.name,
    required this.description,
    required this.address,
    required this.coordinates,
    required this.images,
    this.createdAt,
    this.updatedAt,
  });
// CopyWith method
  Activity copyWith({
    String? id,
    String? dayId,
    String? itineraryId,
    String? name,
    String? description,
    String? address,
    Coordinates? coordinates,
    List<dynamic>? images,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Activity(
      id: id ?? this.id,
      dayId: dayId ?? this.dayId,
      itineraryId: itineraryId ?? this.itineraryId,
      name: name ?? this.name,
      description: description ?? this.description,
      address: address ?? this.address,
      coordinates: coordinates ?? this.coordinates,
      images: images ?? this.images,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityToJson(this);
}
