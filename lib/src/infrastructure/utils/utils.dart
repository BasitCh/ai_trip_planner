import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_hero/global/navigation.dart';
import 'package:widgets_book/widgets_book.dart';

const kHeadingTextStyle = TextStyle(
  fontSize: 32,
  fontWeight: FontWeight.w700,
);

BoxDecoration backgroundDecoration = BoxDecoration(color: AppColors.primary);

Timestamp? dateFromJson(Timestamp? val) => val == null
    ? null
    : Timestamp.fromMillisecondsSinceEpoch(val.millisecondsSinceEpoch);

Timestamp? dateToJson(Timestamp? time) => time == null
    ? null
    : Timestamp.fromMillisecondsSinceEpoch(time.millisecondsSinceEpoch);

DateTime? dateFromJsonOnlyDate(DateTime? val) => val == null
    ? null
    : DateTime.fromMillisecondsSinceEpoch(val.millisecondsSinceEpoch);
DateTime? dateToJsonOnlyDate(DateTime? time) => time == null
    ? null
    : DateTime.fromMillisecondsSinceEpoch(time.millisecondsSinceEpoch);

const blackLinearGradient = LinearGradient(
    begin: Alignment(0.03, -1.00),
    end: Alignment(-0.03, 1),
    colors: [Color(0x00D9D9D9), Color(0xFF000706)]);

final shadowBoxDecoration = BoxDecoration(
  color: AppColors.white,
  borderRadius: BorderRadius.circular(20),
  boxShadow: [
    boxShadow,
  ],
);

final boxShadow = BoxShadow(
  color: AppColors.blackShadow.withOpacity(0.1),
  spreadRadius: 0,
  blurRadius: 20,
  offset: const Offset(0, 10), // changes position of shadow
);

final dimBoxShadow = BoxShadow(
  color: AppColors.blackShadow.withOpacity(0.01),
  spreadRadius: 0,
  blurRadius: 20,
  offset: const Offset(0, 0), // changes position of shadow
);

void navigateBack() {
  final context = Navigation.router.routerDelegate.navigatorKey.currentContext;
  if (context != null) {
    context.pop();
  }
}

// **** IGMU TEXT STYLES ****
TextStyle? get titleLarge => theme.textTheme.titleMedium
    ?.copyWith(fontSize: 28, fontWeight: FontWeight.w600);

TextStyle? get titleMedium => theme
    .textTheme.titleMedium; // 24/ 400 / Playfair Display / 1.2 / textPrimary

TextStyle? get titleMediumSourceSerif => theme
    .textTheme.headlineMedium; // 24/ 600 / Source Serif / 1.2 / textPrimary

TextStyle? get titleMediumSair => theme.textTheme.headlineMedium?.copyWith(
    fontFamily: FontFamily.inter); // 24/ 600 / Source Serif / 1.2 / textPrimary

TextStyle? get titleXMediumSourceSerif => theme.textTheme.headlineMedium
    ?.copyWith(fontSize: 20.sp); // 20/ 600 / Source Serif / 1.2 / textPrimary

TextStyle? get titleXMediumSaira => theme.textTheme.headlineMedium
    ?.copyWith(fontSize: 20.sp, fontFamily: FontFamily.saira);

TextStyle? get titleMediumSaira => theme.textTheme.headlineMedium?.copyWith(
    fontWeight: FontWeight.bold,
    fontFamily: FontFamily.saira); // 24/ 600 / Urbanist / 1.2 / textPrimary

TextStyle? get buttonTitle =>
    theme.textTheme.titleLarge; // 18/ 600 / Urbanist / 1.2 / backgroundColor

TextStyle? get listTileTitleSmall => buttonTitle?.copyWith(
    fontWeight: AppFontWeight.semiBold,
    color: AppColors.textPrimary); // 16/ 600 / Urbanist / 1.2 / backgroundColor

TextStyle? get titleSmall =>
    theme.textTheme.displaySmall; // 18/ 500 / Urbanist / 1.2 / textSecondary

TextStyle? get headerStyle => buttonTitle?.copyWith(
    fontWeight: AppFontWeight.bold,
    color: AppColors.textBlack,
    fontFamily: FontFamily.saira,
    fontSize: 18,
    letterSpacing: -0.7); // 18/ 700 / Urbanist / 1.2 / backgroundColor

TextStyle? get headerStyleInter => buttonTitle?.copyWith(
    fontWeight: AppFontWeight.bold,
    color: AppColors.textBlack,
    fontFamily: FontFamily.inter,
    fontSize: 18,
    letterSpacing: -0.7);

TextStyle? get titleXSmallWhite => theme.textTheme.displaySmall?.copyWith(
    fontSize: 16.sp,
    color: AppColors.white,
    fontWeight: AppFontWeight.semiBold,
    fontFamily: FontFamily.inter); // 16/ 600 / inter / 1.2 / textSecondary

TextStyle? get titleXSmall => theme.textTheme.displaySmall?.copyWith(
    fontSize: 16.sp,
    color: AppColors.textPrimary,
    fontFamily: FontFamily.inter,
    fontWeight:
        AppFontWeight.medium); // 16/ 500 / Urbanist / 1.2 / textSecondary

TextStyle? get appBarLabel => theme.textTheme.displaySmall?.copyWith(
      fontSize: 14.sp,
      color: AppColors.black,
      fontWeight: AppFontWeight.semiBold,
      fontFamily: FontFamily.inter,
    );

TextStyle? get titleXSmallWhiteInter => theme.textTheme.displaySmall?.copyWith(
    fontSize: 16.sp,
    color: AppColors.white,
    fontWeight: AppFontWeight.semiBold,
    fontFamily: FontFamily.inter); // 16/ 600 / inter / 1.2 / textSecondary

TextStyle? get titleXSmallBlackInter => theme.textTheme.displaySmall?.copyWith(
    fontSize: 16.sp,
    color: AppColors.black,
    fontWeight: AppFontWeight.bold,
    fontFamily: FontFamily.inter); // 16/ 700 / inter / 1.2 / textSecondary

TextStyle? get bodyMedium =>
    theme.textTheme.bodyMedium; // 14/ 400 / Urbanist / 1.2 / textPrimary

TextStyle? get subTitleStyle => theme.textTheme.bodyMedium?.copyWith(
    fontFamily: FontFamily.inter,
    letterSpacing: 0.4,
    fontSize: 14,
    color: AppColors.textSecondary);

TextStyle? get listTileSubtitle => bodyMedium?.copyWith(
    fontWeight: AppFontWeight.medium,
    color: AppColors.textSecondary); // 14/ 500 / Urbanist / 1.2 / textPrimary

TextStyle? get bodySmall => theme.textTheme.bodyMedium?.copyWith(
      fontSize: 12.sp,
      color: AppColors.textSecondary,
      fontFamily: FontFamily.inter,
    ); // 12/ 400 / Urbanist / 1.2 / textSecondary
TextStyle? get buttonStyle => theme.textTheme.bodyMedium?.copyWith(
      fontSize: 20.sp,
      color: AppColors.white,
      fontWeight: FontWeight.w500,
      fontFamily: FontFamily.saira,
    );
TextStyle? get bodySmallWhite => theme.textTheme.bodyMedium?.copyWith(
    fontSize: 12.sp,
    fontWeight: AppFontWeight.medium,
    color: AppColors.white,
    fontFamily: FontFamily.saira); // 12/ 500 / SF Pro / 1.2 / textSecondary

TextStyle? get unselectedLabel => theme.textTheme.bodyMedium?.copyWith(
    fontSize: 12.sp,
    fontWeight: AppFontWeight.medium,
    color: AppColors.unSelectedLabel,
    fontFamily: FontFamily.saira); // 12/ 500 / SF Pro / 1.2 / textSecondary

TextStyle? get selectedLabel => theme.textTheme.bodyMedium?.copyWith(
    fontSize: 12.sp,
    fontWeight: AppFontWeight.medium,
    color: AppColors.primary,
    fontFamily: FontFamily.saira); // 12/ 500 / SF Pro / 1.2 / textSecondary

TextStyle? get expandableTileTitle => theme.textTheme.titleSmall?.copyWith(
    color: AppColors.white,
    fontWeight: FontWeight.w400,
    fontFamily:
        FontFamily.inter); // 18/ 400 / Source Serif / 1.2 / textSecondary

Color get randomColor => Color.fromARGB(255, math.Random().nextInt(256),
    math.Random().nextInt(256), math.Random().nextInt(256));

String getDateTimeToString(DateTime? date) {
  return date == null ? '-' : date.toDateMonthYear();
}

showImageDialog(BuildContext context, String imageUrl) => showDialog(
    barrierColor: AppColors.black.withOpacity(0.2),
    builder: (context) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  context.pop();
                  // Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppColors.white,
                ),
              ),
            ),
            Gap(8.h),
            InteractiveViewer(
              child: Container(
                width: context.width,
                decoration: const BoxDecoration(
                  color: AppColors.black,
                ),
                child: Image.network(
                  imageUrl,
                  width: context.width,
                  fit: BoxFit.contain,
                  height: context.width,
                ),
              ),
            ),
          ],
        ),
      );
    },
    context: context);
