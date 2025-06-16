// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requester.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RequesterAdapter extends TypeAdapter<Requester> {
  @override
  final int typeId = 17;

  @override
  Requester read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Requester(
      id: fields[0] as String?,
      name: fields[1] as String?,
      profileUrl: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Requester obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.profileUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RequesterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Requester _$RequesterFromJson(Map<String, dynamic> json) => Requester(
      id: json['id'] as String?,
      name: json['name'] as String?,
      profileUrl: json['profileUrl'] as String? ?? '',
    );

Map<String, dynamic> _$RequesterToJson(Requester instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('profileUrl', instance.profileUrl);
  return val;
}
