import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';

part 'collection.g.dart';

@JsonSerializable(explicitToJson: true)
class Collection {
  final String id;
  final String name;
  final String image;
  final List<String> itineraries;
  @JsonKey(fromJson: dateFromJson, toJson: dateToJson)
  final Timestamp? createdAt;
  @JsonKey(fromJson: dateFromJson, toJson: dateToJson)
  final Timestamp? updatedAt;

  Collection({
    required this.id,
    required this.name,
    required this.image,
    required this.itineraries,
    this.createdAt,
    this.updatedAt,

  });

  factory Collection.fromJson(String id, Map<String, dynamic> json) =>
      _$CollectionFromJson(json).copyWith(id: id);

  Map<String, dynamic> toJson() => _$CollectionToJson(this);

  /// ✅ `copyWith` method for immutability
  Collection copyWith({
    String? id,
    String? name,
    String? image,
    List<String>? itineraries,
  }) {
    return Collection(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      itineraries: itineraries ?? this.itineraries,
    );
  }

}

