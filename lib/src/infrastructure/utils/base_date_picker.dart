import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';
import 'package:travel_hero/global/navigation.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:widgets_book/widgets_book.dart';

Future<DateTime?> baseDatePicker(BuildContext context, {bool? includeTime, DateTime? initialDate}) async {
  DateTime? selectedDate = initialDate ?? DateTime.now();
  Completer<DateTime?> completer = Completer();

  showCupertinoModalPopup(
    context: context,
    builder: (context) => CupertinoTheme(
      data: CupertinoThemeData(
        textTheme: CupertinoTextThemeData(
          dateTimePickerTextStyle: listTileSubtitle?.copyWith(fontSize: 10.sp),
        ),
      ),
      child: Container(
        height: 250.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.h),
          color: AppColors.white,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Transform.scale(
                scale: 1.35,
                child: SizedBox(
                  height: 185.h,
                  child: CupertinoDatePicker(
                    itemExtent: 30,
                    selectionOverlayBuilder: (BuildContext context, {required int selectedIndex, required int columnCount}) {
                      return const CupertinoPickerDefaultSelectionOverlay(
                        capStartEdge: false,
                        capEndEdge: false,
                      );
                    },
                    initialDateTime: initialDate,
                    onDateTimeChanged: (DateTime val) {
                      selectedDate = val;
                    },
                    mode: includeTime == true ? CupertinoDatePickerMode.dateAndTime : CupertinoDatePickerMode.date,
                    dateOrder: DatePickerDateOrder.dmy,
                    maximumDate: DateTime(2100),
                    minimumDate: DateTime(2000),
                  ),
                ),
              ),
              Gap(12.h),
              CupertinoButton(
                child: Text('Done', style: listTileSubtitle?.copyWith(color: AppColors.secondary)),
                onPressed: () {
                  final currentContext = Navigation.router.routerDelegate.navigatorKey.currentContext;
                  if (currentContext == null) return;
                  Navigator.of(currentContext).pop();
                  completer.complete(selectedDate);
                },
              ),
            ],
          ),
        ),
      ),
    ),
  );

  return completer.future;
}

Future<DateTime?> baseTimePicker(BuildContext context) async {
  DateTime? selectedDate = DateTime.now();
  Completer<DateTime?> completer = Completer();

  showCupertinoModalPopup(
    context: context,
    builder: (context) => CupertinoTheme(
      data: CupertinoThemeData(
        textTheme: CupertinoTextThemeData(
          dateTimePickerTextStyle: listTileSubtitle?.copyWith(fontSize: 10.sp),
        ),
      ),
      child: Container(
        height: 250.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.h),
          color: AppColors.white,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Transform.scale(
                scale: 1.35,
                child: SizedBox(
                  height: 185.h,
                  child: CupertinoDatePicker(
                    itemExtent: 30,
                    initialDateTime: DateTime.now(),
                    onDateTimeChanged: (DateTime val) {
                      selectedDate = val;
                    },
                    mode: CupertinoDatePickerMode.time,
                    dateOrder: DatePickerDateOrder.dmy,
                    maximumDate: DateTime(2100),
                    minimumDate: DateTime(2000),
                  ),
                ),
              ),
              Gap(12.h),
              CupertinoButton(
                child: Text('Done', style: listTileSubtitle?.copyWith(color: AppColors.secondary)),
                onPressed: () {
                  final currentContext = Navigation.router.routerDelegate.navigatorKey.currentContext;
                  if (currentContext == null) return;
                  Navigator.of(currentContext).pop();
                  completer.complete(selectedDate);
                },
              ),
            ],
          ),
        ),
      ),
    ),
  );

  return completer.future;
}

String timeAgo(Timestamp? timestamp) {
  DateTime dateTime = timestamp?.toDate() ?? DateTime.now();
  Duration difference = DateTime.now().difference(dateTime);

  if (difference.inSeconds < 60) {
    return 'Just now';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} min ago';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} hours ago';
  } else if (difference.inDays < 7) {
    return '${difference.inDays} days ago';
  } else if (difference.inDays < 30) {
    return '${(difference.inDays / 7).floor()} weeks ago';
  } else if (difference.inDays < 365) {
    return '${(difference.inDays / 30).floor()} months ago';
  } else {
    return '${(difference.inDays / 365).floor()} years ago';
  }
}
String timeAgoCompleted(DateTime dateTime) {
  Duration difference = DateTime.now().difference(dateTime);

  if (difference.inSeconds < 60) {
    return 'Just now';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} min ago';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} hr ago';
  } else if (difference.inDays < 7) {
    return '${difference.inDays} days ago';
  } else if (difference.inDays < 30) {
    return '${(difference.inDays / 7).floor()} weeks ago';
  } else if (difference.inDays < 365) {
    return '${(difference.inDays / 30).floor()} months ago';
  } else {
    return '${(difference.inDays / 365).floor()} years ago';
  }
}
String calculateTripDuration(int duration) {

  // Ensure at least "1 Day" even if the trip is very short
  return "${duration > 0 ? duration : 1} ${duration == 1 ? 'Day' : 'Days'}";
}