import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:travel_hero/src/infrastructure/utils/constants.dart';

part 'requester.g.dart';

@HiveType(typeId: HiveConstants.requesterTypeId)
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Requester {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final String? profileUrl;

  Requester({
    required this.id,
    required this.name,
    this.profileUrl = '',
  });

  factory Requester.fromJson(Map<String, dynamic> json) =>
      _$RequesterFromJson(json);

  Map<String, dynamic> toJson() => _$RequesterToJson(this);
}
