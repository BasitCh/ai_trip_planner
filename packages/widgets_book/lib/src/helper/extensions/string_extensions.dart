// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ').toLowerCase()
      .split(' ')
      .map((String str) => str.toCapitalized())
      .join(' ');

  String removeLastCharacter() {
    if (length > 0) {
      return substring(0, length - 1);
    } else {
      return this;
    }
  }

  String removeFirstCharacter() {
    if (length > 0) {
      return substring(1);
    } else {
      return this;
    }
  }

  String separateIfUnderscored() {
    if (!contains('_')) {
      return this;
    } else {
      return split('_').join(' ');
    }
  }

  String toCurrencyFormat({String prefix = '', int decimalDigits = 2}) {
    try {
      return NumberFormat.simpleCurrency(
        name: prefix,
        decimalDigits: decimalDigits,
      ).format(double.parse(this));
    } catch (e) {
      return this;
    }
  }

  double toDouble() {
    return double.tryParse(this) ?? 0.0;
  }

  String get toDate {
    final date = DateTime.parse(this);
    final newFormat = DateFormat('yMMMd');
    final updatedDt = newFormat.format(date);
    return updatedDt;
  }

  String get toTime {
    final date = DateTime.parse(this);
    final newFormat = DateFormat('jm');
    final updatedDt = newFormat.format(date);
    return updatedDt;
  }

  String get parseToDate {
    try {
      return DateTime.parse(this)
          .toUtc()
          .toString()
          .replaceAll(RegExp('Z'), ' ');
    } catch (e) {
      return '** *** **';
    }
  }

  String bullet() {
    return '•   $this';
  }

  bool isEsimSupported() {
    if (toLowerCase().contains('not support')) {
      return false;
    } else {
      return true;
    }
  }

  String trimDots() {
    return replaceAll('.', '');
  }

  String esimSMDPCode() {
    final startIndex = indexOf(r'$') + 1;
    final endIndex = indexOf(r'$', startIndex);
    final hostnameSubstring = substring(startIndex, endIndex);
    return hostnameSubstring;
  }

  String esimActivationCode() {
    final parts = split(r'$');
    final desiredString = parts[2];
    return desiredString;
  }

  bool isQrCodeNotEmpty() {
    return isNotEmpty && length > 10;
  }
}

extension NullableStringExtension on String? {
  bool isDeviceNotFound() {
    return this == 'DEVICE_NOT_FOUND';
  }
}
