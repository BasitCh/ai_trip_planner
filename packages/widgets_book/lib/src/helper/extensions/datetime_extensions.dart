// ignore_for_file: depend_on_referenced_packages

import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String timeAgo({bool numericDates = true}) {
    final date2 = DateTime.now();
    final difference = date2.difference(this);

    if ((difference.inDays / 365).floor() >= 2) {
      return '${(difference.inDays / 365).floor()} years';
    } else if ((difference.inDays / 365).floor() >= 1) {
      return numericDates ? '1 year' : 'Last year';
    } else if ((difference.inDays / 30).floor() >= 2) {
      return '${(difference.inDays / 30).floor()} months';
    } else if ((difference.inDays / 30).floor() >= 1) {
      return numericDates ? '1 month' : 'Last month';
    } else if ((difference.inDays / 7).floor() >= 2) {
      return '${(difference.inDays / 7).floor()} weeks';
    } else if ((difference.inDays / 7).floor() >= 1) {
      return numericDates ? '1 week' : 'Last week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days';
    } else if (difference.inDays >= 1) {
      return numericDates ? '1 day' : 'Yesterday';
    } else if (difference.inHours >= 1) {
      return numericDates ? 'Today' : 'An hour';
    }  else if (difference.inMinutes >= 1) {
      return numericDates ? 'Today' : 'A minute';
    } else if (difference.inSeconds >= 3) {
      return 'Today';
    } else {
      return 'Today';
    }
  }

  String toFormat(String format) {
    final date = DateFormat(format).format(this);
    return date;
  }

  String toMonthDateYear() {
    final date = DateFormat('MMM dd, yyyy').format(this);
    return date;
  }

  String toDateMonthYear() {
    final date = DateFormat('dd MMM yyyy').format(this);
    return date;
  }

  bool areDaysEqual({required DateTime to}) {
    final from = DateTime(year, month, day);
    to = DateTime(to.year, to.month, to.day);
    if (from == to) {
      return true;
    } else {
      return false;
    }
  }
}
