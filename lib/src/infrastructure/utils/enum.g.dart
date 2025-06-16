// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GenderAdapter extends TypeAdapter<Gender> {
  @override
  final int typeId = 13;

  @override
  Gender read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Gender.male;
      case 1:
        return Gender.female;
      default:
        return Gender.male;
    }
  }

  @override
  void write(BinaryWriter writer, Gender obj) {
    switch (obj) {
      case Gender.male:
        writer.writeByte(0);
        break;
      case Gender.female:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GenderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LoginRegisterMethodAdapter extends TypeAdapter<LoginRegisterMethod> {
  @override
  final int typeId = 15;

  @override
  LoginRegisterMethod read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return LoginRegisterMethod.email;
      case 1:
        return LoginRegisterMethod.google;
      case 2:
        return LoginRegisterMethod.facebook;
      case 3:
        return LoginRegisterMethod.apple;
      default:
        return LoginRegisterMethod.email;
    }
  }

  @override
  void write(BinaryWriter writer, LoginRegisterMethod obj) {
    switch (obj) {
      case LoginRegisterMethod.email:
        writer.writeByte(0);
        break;
      case LoginRegisterMethod.google:
        writer.writeByte(1);
        break;
      case LoginRegisterMethod.facebook:
        writer.writeByte(2);
        break;
      case LoginRegisterMethod.apple:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginRegisterMethodAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
