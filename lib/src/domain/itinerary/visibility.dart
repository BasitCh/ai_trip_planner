import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:travel_hero/src/domain/itinerary/requester.dart';
import 'package:travel_hero/src/infrastructure/utils/constants.dart';

part 'visibility.g.dart';

enum VisibilityStatus {
  private,
  public,
}

@HiveType(typeId: HiveConstants.visibilityTypeId)
@JsonSerializable(explicitToJson: true)
class TravelVisibility {
  @HiveField(0)
  final String type; // "private" or "public"
  @HiveField(1)
  final List<String> allowedUsers; // Users who can see this itinerary
  @HiveField(2)
  final List<Requester> requesters;

  TravelVisibility(
      {required this.type,
      required this.allowedUsers,
      this.requesters = const []});

  factory TravelVisibility.public() => TravelVisibility(
        type: VisibilityStatus.public.name,
        allowedUsers: [],
      );

  factory TravelVisibility.fromJson(Map<String, dynamic> json) =>
      _$TravelVisibilityFromJson(json);

  Map<String, dynamic> toJson() => _$TravelVisibilityToJson(this);
}
