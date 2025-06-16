// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visibility.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TravelVisibilityAdapter extends TypeAdapter<TravelVisibility> {
  @override
  final int typeId = 16;

  @override
  TravelVisibility read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TravelVisibility(
      type: fields[0] as String,
      allowedUsers: (fields[1] as List).cast<String>(),
      requesters: (fields[2] as List).cast<Requester>(),
    );
  }

  @override
  void write(BinaryWriter writer, TravelVisibility obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.allowedUsers)
      ..writeByte(2)
      ..write(obj.requesters);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TravelVisibilityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TravelVisibility _$TravelVisibilityFromJson(Map<String, dynamic> json) =>
    TravelVisibility(
      type: json['type'] as String,
      allowedUsers: (json['allowedUsers'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      requesters: (json['requesters'] as List<dynamic>?)
              ?.map((e) => Requester.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$TravelVisibilityToJson(TravelVisibility instance) =>
    <String, dynamic>{
      'type': instance.type,
      'allowedUsers': instance.allowedUsers,
      'requesters': instance.requesters.map((e) => e.toJson()).toList(),
    };
