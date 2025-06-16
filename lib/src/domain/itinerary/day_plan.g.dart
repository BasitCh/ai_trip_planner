// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_plan.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DayPlanAdapter extends TypeAdapter<DayPlan> {
  @override
  final int typeId = 11;

  @override
  DayPlan read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DayPlan(
      id: fields[0] as String?,
      itineraryId: fields[1] as String?,
      day: fields[2] as int,
      title: fields[4] as String,
      date: fields[3] as String,
      activities: (fields[5] as List).cast<Activity>(),
      createdAt: fields[7] as DateTime?,
      updatedAt: fields[8] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, DayPlan obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.itineraryId)
      ..writeByte(2)
      ..write(obj.day)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.title)
      ..writeByte(5)
      ..write(obj.activities)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DayPlanAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DayPlan _$DayPlanFromJson(Map<String, dynamic> json) => DayPlan(
      id: json['id'] as String?,
      itineraryId: json['itineraryId'] as String?,
      day: (json['day'] as num).toInt(),
      title: json['title'] as String,
      date: json['date'] as String,
      activities: (json['activities'] as List<dynamic>?)
              ?.map((e) => Activity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$DayPlanToJson(DayPlan instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('itineraryId', instance.itineraryId);
  val['day'] = instance.day;
  val['date'] = instance.date;
  val['title'] = instance.title;
  writeNotNull('createdAt', instance.createdAt?.toIso8601String());
  writeNotNull('updatedAt', instance.updatedAt?.toIso8601String());
  return val;
}
