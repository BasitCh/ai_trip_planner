import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:travel_hero/src/infrastructure/utils/enum.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:travel_hero/src/infrastructure/utils/values.dart';

part 'app_user.g.dart';

@JsonSerializable(explicitToJson: true)
@HiveType(typeId: HiveValues.userTypeId)
class AppUser extends HiveObject {
  AppUser({this.userEmail, this.creationDate, this.isEmailVerified, this.uid, this.username, this.signupMethod, this.isWelcomeMessageSeen,this.pictureUrl,this.coverPhotoUrl,this.isPublicProfile,this.tripPlanRate,this.isEmail,this.isNotification});

  factory AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);

  Map<String, dynamic> toJson() => _$AppUserToJson(this);

  @HiveField(0)
  final String? userEmail;
  @HiveField(1)
  @JsonKey(fromJson: dateFromJson, toJson: dateToJson)
  final Timestamp? creationDate;
  @HiveField(2)
  final bool? isEmailVerified;
  @HiveField(3)
  String? uid;
  @HiveField(4)
  String? username;
  @HiveField(5)
  @JsonKey(fromJson: LoginRegisterMethod.fromJson, toJson: LoginRegisterMethod.toJson)
  LoginRegisterMethod? signupMethod;
  @HiveField(6)
  bool? isWelcomeMessageSeen;
  @HiveField(7)
  String? pictureUrl;
  @HiveField(8)
  String? coverPhotoUrl;
  @HiveField(9)
  bool? isPublicProfile;
  @HiveField(10)
  double? tripPlanRate;
  @HiveField(11)
  bool? isNotification;
  @HiveField(12)
  bool? isEmail;
  AppUser copyWith({String? coverPhotoUrl,bool? isPublicProfile,double? tripPlanRate,bool? isNotification,bool? isEmail}) {
    return AppUser(
      uid: uid,
      creationDate: creationDate,
      isEmailVerified: isEmailVerified,
      isWelcomeMessageSeen: isWelcomeMessageSeen,
      pictureUrl: pictureUrl,
      signupMethod: signupMethod,
      userEmail: userEmail,
      username: username,
      tripPlanRate: tripPlanRate??this.tripPlanRate,
      isPublicProfile: isPublicProfile??this.isPublicProfile,
      coverPhotoUrl: coverPhotoUrl ?? this.coverPhotoUrl,
      isEmail: isEmail??this.isEmail,
      isNotification: isNotification??this.isEmail
    );
  }
}
