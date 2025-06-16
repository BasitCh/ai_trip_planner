// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Collection _$CollectionFromJson(Map<String, dynamic> json) => Collection(
      id: json['id'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      itineraries: (json['itineraries'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      createdAt: dateFromJson(json['createdAt'] as Timestamp?),
      updatedAt: dateFromJson(json['updatedAt'] as Timestamp?),
    );

Map<String, dynamic> _$CollectionToJson(Collection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'itineraries': instance.itineraries,
      'createdAt': dateToJson(instance.createdAt),
      'updatedAt': dateToJson(instance.updatedAt),
    };
