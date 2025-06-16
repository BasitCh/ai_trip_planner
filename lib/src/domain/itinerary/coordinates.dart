import 'package:hive_flutter/hive_flutter.dart';
import 'package:travel_hero/src/infrastructure/utils/constants.dart';
import 'package:widgets_book/widgets_book.dart';
part 'coordinates.g.dart';

@HiveType(typeId: HiveConstants.coordinatesTypeID)
@JsonSerializable(
  includeIfNull: false,
  explicitToJson: true,
)
class Coordinates {
  @HiveField(0)
  final double lat;
  @HiveField(1)
  final double lng;

  Coordinates({
    required this.lat,
    required this.lng,
  });

  factory Coordinates.fromJson(Map<String, dynamic> json) =>
      _$CoordinatesFromJson(json);

  Map<String, dynamic> toJson() => _$CoordinatesToJson(this);
}
