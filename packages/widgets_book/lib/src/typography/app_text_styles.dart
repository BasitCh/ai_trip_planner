import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

/// The app consists of two main text style definitions: UI and Content.
///
/// Content text style is primarily used for all content-based components,
/// e.g. news feed including articles and sections, while the UI text style
/// is used for the rest of UI components.
///
/// The default app's [TextTheme] is [AppTheme.uiTextTheme].
///
/// Use [ContentThemeOverrideBuilder] to override the default [TextTheme]
/// to [AppTheme.contentTextTheme].

/// UI Text Style Definitions
abstract class UITextStyle {
  static const TextStyle _baseTextStyle = TextStyle(
      fontFamily: FontFamily.saira,
      letterSpacing: 0.2,
      color: AppColors.textBlack,
      fontFamilyFallback: [FontFamily.saira, FontFamily.inter,],);

  /// Headline 1 Text Style
  static TextStyle get headline1 {
    return _baseTextStyle.copyWith(
      fontSize: 60.sp,
      fontWeight: AppFontWeight.semiBold,
    );
  }

  /// Headline 2 Text Style
  static TextStyle get headline2 {
    return _baseTextStyle.copyWith(
      fontSize: 37.sp,
      fontWeight: AppFontWeight.light,
    );
  }

  /// Headline 3 Text Style
  static TextStyle get headline3 {
    return _baseTextStyle.copyWith(
      fontSize: 17.sp,
      fontWeight: AppFontWeight.medium,
      color: AppColors.textSecondary,
      height: 1.6,
    );
  }

  /// Headline 4 Text Style
  static TextStyle get headline4 {
    return _baseTextStyle.copyWith(
      fontSize: 24.sp,
      fontWeight: AppFontWeight.semiBold,
      fontFamily: FontFamily.saira,
      fontFamilyFallback: [
        FontFamily.saira,
      ],
      color: AppColors.textPrimary,
    );
  }

  /// Headline 5 Text Style
  static TextStyle get headline5 {
    return _baseTextStyle.copyWith(
      fontSize: 17.sp,
      fontWeight: AppFontWeight.medium,
    );
  }

  /// Headline 6 Text Style
  static TextStyle get headline6 {
    return _baseTextStyle.copyWith(
      fontSize: 17.sp,
      fontWeight: AppFontWeight.semiBold,
      color: AppColors.backgroundColor,
    );
  }

  /// Subtitle 1 Text Style
  static TextStyle get subtitle1 {
    return _baseTextStyle.copyWith(
      fontSize: 24.sp,
      fontWeight: AppFontWeight.regular,
      fontFamily: FontFamily.inter,
      color: AppColors.textPrimary,
      height: 1.3,
    );
  }

  /// Subtitle 2 Text Style
  static TextStyle get subtitle2 {
    return _baseTextStyle.copyWith(
      fontSize: 18.sp,
      fontWeight: AppFontWeight.medium,
    );
  }

  static TextStyle get subtitle3 {
    return _baseTextStyle.copyWith(
      fontSize: 18.sp,
      fontWeight: AppFontWeight.semiBold,
      color: AppColors.textLabel,
    );
  }

  /// Body Text 1 Text Style
  static TextStyle get bodyText1 {
    return _baseTextStyle.copyWith(
      fontSize: 17.sp,
      fontWeight: AppFontWeight.medium,
    );
  }

  /// Body Text 2 Text Style (the default)
  static TextStyle get bodyText2 {
    return _baseTextStyle.copyWith(
      fontSize: 14.sp,
      fontWeight: AppFontWeight.regular,
      color: AppColors.textPrimary,
    );
  }

  /// Caption Text Style
  static final TextStyle caption = _baseTextStyle.copyWith(
    fontSize: 12.sp,
    height: 1.33,
    letterSpacing: 0.4,
  );

  /// Button Text Style
  static final TextStyle button = _baseTextStyle.copyWith(
    fontSize: 16.sp,
    height: 1.42,
    letterSpacing: 0.1,
  );

  /// Overline Text Style
  static final TextStyle overline = _baseTextStyle.copyWith(
    fontSize: 12.sp,
    height: 1.33,
    letterSpacing: 0.5,
  );

  /// Label Small Text Style
  static final TextStyle labelSmall = _baseTextStyle.copyWith(
    fontSize: 11.sp,
    height: 1.45,
    letterSpacing: 0.5,
  );
}

/// Content Text Style Definitions
// abstract class ContentTextStyle {
//   static const _baseTextStyle = TextStyle(
//       package: 'widgetbook',
//       fontWeight: AppFontWeight.regular,
//       decoration: TextDecoration.none,
//       textBaseline: TextBaseline.alphabetic,
//       color: AppColors.textPrimary);
//
//   /// Display 1 Text Style
//   static final TextStyle display1 = _baseTextStyle.copyWith(
//     fontSize: 64,
//     fontWeight: AppFontWeight.bold,
//     height: 1.18,
//     letterSpacing: -0.5,
//   );
//
//   /// Display 2 Text Style
//   static final TextStyle display2 = _baseTextStyle.copyWith(
//     fontSize: 57,
//     fontWeight: AppFontWeight.bold,
//     height: 1.12,
//     letterSpacing: -0.25,
//   );
//
//   /// Display 3 Text Style
//   static final TextStyle display3 = _baseTextStyle.copyWith(
//     fontSize: 45,
//     fontWeight: AppFontWeight.bold,
//     height: 1.15,
//   );
//
//   /// Headline 1 Text Style
//   static final TextStyle headline1 = _baseTextStyle.copyWith(
//     fontSize: 36,
//     fontWeight: AppFontWeight.semiBold,
//     height: 1.22,
//   );
//
//   /// Headline 2 Text Style
//   static final TextStyle headline2 = _baseTextStyle.copyWith(
//     fontSize: 32,
//     fontWeight: AppFontWeight.medium,
//     height: 1.25,
//   );
//
//   /// Headline 3 Text Style
//   static final TextStyle headline3 = _baseTextStyle.copyWith(
//     fontSize: 28,
//     fontWeight: AppFontWeight.medium,
//     height: 1.28,
//   );
//
//   /// Headline 4 Text Style
//   static final TextStyle headline4 = _baseTextStyle.copyWith(
//     fontSize: 24,
//     fontWeight: AppFontWeight.semiBold,
//     height: 1.33,
//   );
//
//   /// Headline 5 Text Style
//   static final TextStyle headline5 = _baseTextStyle.copyWith(
//     fontSize: 22,
//     height: 1.27,
//   );
//
//   /// Headline 6 Text Style
//   static final TextStyle headline6 = _baseTextStyle.copyWith(
//     fontSize: 18,
//     fontWeight: AppFontWeight.semiBold,
//   );
//
//   /// Subtitle 1 Text Style
//   static final TextStyle subtitle1 = _baseTextStyle.copyWith(
//     fontSize: 1,
//     height: 1.5,
//     letterSpacing: 0.1,
//   );
//
//   /// Subtitle 2 Text Style
//   static final TextStyle subtitle2 = _baseTextStyle.copyWith(
//     fontSize: 14,
//     fontWeight: AppFontWeight.medium,
//     letterSpacing: 0.1,
//   );
//
//   /// Body Text 1 Text Style
//   static final TextStyle bodyText1 = _baseTextStyle.copyWith(
//     fontSize: 16,
//     height: 1.5,
//     letterSpacing: 0.5,
//   );
//
//   /// Body Text 2 Text Style (the default)
//   static final TextStyle bodyText2 = _baseTextStyle.copyWith(
//     fontSize: 14,
//     height: 1.42,
//     letterSpacing: 0.25,
//   );
//
//   /// Button Text Style
//   static final TextStyle button = _baseTextStyle.copyWith(
//     fontSize: 14,
//     fontWeight: AppFontWeight.medium,
//     height: 1.42,
//     letterSpacing: 0.1,
//   );
//
//   /// Caption Text Style
//   static final TextStyle caption = _baseTextStyle.copyWith(
//     fontSize: 12,
//     height: 1.33,
//     letterSpacing: 0.4,
//   );
//
//   /// Overline Text Style
//   static final TextStyle overline = _baseTextStyle.copyWith(
//     fontWeight: AppFontWeight.semiBold,
//     fontSize: 12,
//     height: 1.33,
//     letterSpacing: 0.5,
//   );
//
//   /// Label Small Text Style
//   static final TextStyle labelSmall = _baseTextStyle.copyWith(
//     fontSize: 11,
//     height: 1.45,
//     letterSpacing: 0.5,
//   );
//
//   // hint text style
//   static TextStyle get hintStyle {
//     return _baseTextStyle.copyWith(
//       fontSize: 16,
//       color: AppColors.gray,
//       fontWeight: AppFontWeight.regular,
//     );
//   }
// }
