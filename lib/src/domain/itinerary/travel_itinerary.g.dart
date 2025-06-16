// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'travel_itinerary.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TravelItineraryAdapter extends TypeAdapter<TravelItinerary> {
  @override
  final int typeId = 10;

  @override
  TravelItinerary read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TravelItinerary(
      id: fields[0] as String?,
      trip: fields[1] as String?,
      createdBy: fields[2] as String?,
      profileUrl: fields[3] as String?,
      duration: fields[4] as String?,
      destination: fields[5] as String?,
      description: fields[6] as String?,
      price: fields[7] as double?,
      currency: fields[8] as String?,
      symbol: fields[9] as String?,
      dayPlans: (fields[10] as List).cast<DayPlan>(),
      isRequestedItinerary: fields[20] as bool?,
      isPaidPlan: fields[11] as bool,
      rating: fields[12] as double?,
      reviewCount: fields[13] as int?,
      isLiked: fields[14] as bool?,
      createdAt: fields[15] as DateTime?,
      updatedAt: fields[16] as DateTime?,
      userId: fields[17] as String?,
      unlockedBy: (fields[18] as List?)?.cast<String>(),
      isUnlockedForCurrentUser: fields[19] as bool?,
      linkedRequestId: fields[21] as String?,
      visibility: fields[22] as TravelVisibility?,
      mood: fields[23] as String?,
      coverUrls: (fields[24] as List?)?.cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, TravelItinerary obj) {
    writer
      ..writeByte(25)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.trip)
      ..writeByte(2)
      ..write(obj.createdBy)
      ..writeByte(3)
      ..write(obj.profileUrl)
      ..writeByte(4)
      ..write(obj.duration)
      ..writeByte(5)
      ..write(obj.destination)
      ..writeByte(6)
      ..write(obj.description)
      ..writeByte(7)
      ..write(obj.price)
      ..writeByte(8)
      ..write(obj.currency)
      ..writeByte(9)
      ..write(obj.symbol)
      ..writeByte(10)
      ..write(obj.dayPlans)
      ..writeByte(11)
      ..write(obj.isPaidPlan)
      ..writeByte(12)
      ..write(obj.rating)
      ..writeByte(13)
      ..write(obj.reviewCount)
      ..writeByte(14)
      ..write(obj.isLiked)
      ..writeByte(15)
      ..write(obj.createdAt)
      ..writeByte(16)
      ..write(obj.updatedAt)
      ..writeByte(17)
      ..write(obj.userId)
      ..writeByte(18)
      ..write(obj.unlockedBy)
      ..writeByte(19)
      ..write(obj.isUnlockedForCurrentUser)
      ..writeByte(20)
      ..write(obj.isRequestedItinerary)
      ..writeByte(21)
      ..write(obj.linkedRequestId)
      ..writeByte(22)
      ..write(obj.visibility)
      ..writeByte(23)
      ..write(obj.mood)
      ..writeByte(24)
      ..write(obj.coverUrls);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TravelItineraryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TravelItinerary _$TravelItineraryFromJson(Map<String, dynamic> json) =>
    TravelItinerary(
      id: json['id'] as String?,
      trip: json['trip'] as String?,
      createdBy: json['createdBy'] as String?,
      profileUrl: json['profileUrl'] as String?,
      duration: json['duration'] as String?,
      destination: json['destination'] as String?,
      description: json['description'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      currency: json['currency'] as String?,
      symbol: json['symbol'] as String?,
      dayPlans: (json['itinerary'] as List<dynamic>?)
              ?.map((e) => DayPlan.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      isRequestedItinerary: json['isRequestedItinerary'] as bool? ?? false,
      isPaidPlan: json['isPaidPlan'] as bool? ?? false,
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      reviewCount: (json['reviewCount'] as num?)?.toInt(),
      isLiked: json['isLiked'] as bool?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      userId: json['userId'] as String?,
      unlockedBy: (json['unlockedBy'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      linkedRequestId: json['linkedRequestId'] as String?,
      visibility: json['visibility'] == null
          ? null
          : TravelVisibility.fromJson(
              json['visibility'] as Map<String, dynamic>),
      mood: json['mood'] as String?,
      coverUrls: json['coverUrls'] as List<dynamic>? ?? const <String>[],
    );

Map<String, dynamic> _$TravelItineraryToJson(TravelItinerary instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('trip', instance.trip);
  writeNotNull('createdBy', instance.createdBy);
  writeNotNull('profileUrl', instance.profileUrl);
  writeNotNull('duration', instance.duration);
  writeNotNull('destination', instance.destination);
  writeNotNull('description', instance.description);
  writeNotNull('price', instance.price);
  writeNotNull('currency', instance.currency);
  writeNotNull('symbol', instance.symbol);
  val['isPaidPlan'] = instance.isPaidPlan;
  writeNotNull('rating', instance.rating);
  writeNotNull('reviewCount', instance.reviewCount);
  writeNotNull('isLiked', instance.isLiked);
  writeNotNull('createdAt', instance.createdAt?.toIso8601String());
  writeNotNull('updatedAt', instance.updatedAt?.toIso8601String());
  writeNotNull('userId', instance.userId);
  writeNotNull('unlockedBy', instance.unlockedBy);
  writeNotNull('isRequestedItinerary', instance.isRequestedItinerary);
  writeNotNull('linkedRequestId', instance.linkedRequestId);
  writeNotNull('visibility', instance.visibility?.toJson());
  writeNotNull('mood', instance.mood);
  writeNotNull('coverUrls', instance.coverUrls);
  return val;
}
