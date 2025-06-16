// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppUserAdapter extends TypeAdapter<AppUser> {
  @override
  final int typeId = 1;

  @override
  AppUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppUser(
      userEmail: fields[0] as String?,
      creationDate: fields[1] as Timestamp?,
      isEmailVerified: fields[2] as bool?,
      uid: fields[3] as String?,
      username: fields[4] as String?,
      signupMethod: fields[5] as LoginRegisterMethod?,
      isWelcomeMessageSeen: fields[6] as bool?,
      pictureUrl: fields[7] as String?,
      coverPhotoUrl: fields[8] as String?,
      isPublicProfile: fields[9] as bool?,
      tripPlanRate: fields[10] as double?,
      isEmail: fields[12] as bool?,
      isNotification: fields[11] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, AppUser obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.userEmail)
      ..writeByte(1)
      ..write(obj.creationDate)
      ..writeByte(2)
      ..write(obj.isEmailVerified)
      ..writeByte(3)
      ..write(obj.uid)
      ..writeByte(4)
      ..write(obj.username)
      ..writeByte(5)
      ..write(obj.signupMethod)
      ..writeByte(6)
      ..write(obj.isWelcomeMessageSeen)
      ..writeByte(7)
      ..write(obj.pictureUrl)
      ..writeByte(8)
      ..write(obj.coverPhotoUrl)
      ..writeByte(9)
      ..write(obj.isPublicProfile)
      ..writeByte(10)
      ..write(obj.tripPlanRate)
      ..writeByte(11)
      ..write(obj.isNotification)
      ..writeByte(12)
      ..write(obj.isEmail);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUser _$AppUserFromJson(Map<String, dynamic> json) => AppUser(
      userEmail: json['userEmail'] as String?,
      creationDate: dateFromJson(json['creationDate'] as Timestamp?),
      isEmailVerified: json['isEmailVerified'] as bool?,
      uid: json['uid'] as String?,
      username: json['username'] as String?,
      signupMethod:
          LoginRegisterMethod.fromJson(json['signupMethod'] as String?),
      isWelcomeMessageSeen: json['isWelcomeMessageSeen'] as bool?,
      pictureUrl: json['pictureUrl'] as String?,
      coverPhotoUrl: json['coverPhotoUrl'] as String?,
      isPublicProfile: json['isPublicProfile'] as bool?,
      tripPlanRate: (json['tripPlanRate'] as num?)?.toDouble(),
      isEmail: json['isEmail'] as bool?,
      isNotification: json['isNotification'] as bool?,
    );

Map<String, dynamic> _$AppUserToJson(AppUser instance) => <String, dynamic>{
      'userEmail': instance.userEmail,
      'creationDate': dateToJson(instance.creationDate),
      'isEmailVerified': instance.isEmailVerified,
      'uid': instance.uid,
      'username': instance.username,
      'signupMethod': LoginRegisterMethod.toJson(instance.signupMethod),
      'isWelcomeMessageSeen': instance.isWelcomeMessageSeen,
      'pictureUrl': instance.pictureUrl,
      'coverPhotoUrl': instance.coverPhotoUrl,
      'isPublicProfile': instance.isPublicProfile,
      'tripPlanRate': instance.tripPlanRate,
      'isNotification': instance.isNotification,
      'isEmail': instance.isEmail,
    };
