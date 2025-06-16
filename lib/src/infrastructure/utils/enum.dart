import 'package:hive_flutter/hive_flutter.dart';
import 'package:travel_hero/src/infrastructure/utils/constants.dart';

part 'enum.g.dart';

@HiveType(typeId: HiveConstants.genderTypeID)
enum Gender {
  @HiveField(0)
  male,
  @HiveField(1)
  female;

  static String? toJson(Gender? status) {
    return status?.name;
  }

  static Gender? fromJson(String? json) {
    return json != null
        ? Gender.values.firstWhere((e) => e.name == json)
        : null;
  }

}

@HiveType(typeId: HiveConstants.signupMethodTypeId)
enum LoginRegisterMethod {
  @HiveField(0)
  email,
  @HiveField(1)
  google,
  @HiveField(2)
  facebook,
  @HiveField(3)
  apple;

  static String? toJson(LoginRegisterMethod? status) {
    return status?.name;
  }

  static LoginRegisterMethod? fromJson(String? json) {
    return json != null
        ? LoginRegisterMethod.values.firstWhere((e) => e.name == json)
        : null;
  }
}

