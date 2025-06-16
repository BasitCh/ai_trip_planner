import 'package:flutter/material.dart';
import 'package:widgets_book/src/localization/l10n/gen/app_localizations.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerGlobalKey =
    GlobalKey();
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
int calculateAge(DateTime birthDate) {
  final currentDate = DateTime.now();
  var age = currentDate.year - birthDate.year;
  final month1 = currentDate.month;
  final month2 = birthDate.month;
  if (month2 > month1) {
    age--;
  } else if (month1 == month2) {
    final day1 = currentDate.day;
    final day2 = birthDate.day;
    if (day2 > day1) {
      age--;
    }
  }
  return age;
}

String? validateEmail(String? val) {
  const emailRegex =
      r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
  if (val == null || val.isEmpty) {
    return 'Please enter your email address';
  } else if (!RegExp(emailRegex).hasMatch(val)) {
    return 'The email you provided is incorrect *';
  } else {
    return null;
  }
}

String? validateMobile(String? value) {
  const patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  final regExp = RegExp(patttern);
  if (value != null && value.isEmpty) {
    return 'Please enter mobile number';
  } else if (!regExp.hasMatch(value!)) {
    return 'Please enter valid mobile number';
  }
  return null;
}

String? validateString(String? val, {String? message}) {
  if (val != null && val.isNotEmpty) {
    return null;
  } else {
    return message ?? 'Field can not be empty or null.';
  }
}

bool validateValue(String? val) {
  if (val != null && val.isNotEmpty) {
    return true;
  } else {
    return false;
  }
}

late AppLocalizations localizations;
late ThemeData theme;
