// ignore_for_file: unused_element, duplicate_ignore, override_on_non_overriding_member, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:widgets_book/widgets_book.dart';

/// {@template app_theme}
/// The Default App [ThemeData].
/// {@endtemplate}
class AppTheme {
  /// {@macro app_theme}
  const AppTheme();

  /// Default `ThemeData` for App UI.
  ThemeData get themeData {
    return ThemeData(
      highlightColor: AppColors.transparent,
      primaryColor: AppColors.secondary,
      canvasColor: _backgroundColor,
      scaffoldBackgroundColor: _backgroundColor,
      iconTheme: _iconTheme,
      appBarTheme: _appBarTheme,
      dividerTheme: _dividerTheme,
      textTheme: _textTheme,
      inputDecorationTheme: _inputDecorationTheme,
      buttonTheme: _buttonTheme,
      splashColor: AppColors.transparent,
      snackBarTheme: _snackBarTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
      textButtonTheme: _textButtonTheme,
      colorScheme: _colorScheme,
      bottomSheetTheme: _bottomSheetTheme,
      listTileTheme: _listTileTheme,
      switchTheme: _switchTheme,
      progressIndicatorTheme: _progressIndicatorTheme,
      indicatorColor: AppColors.grey.shade400,
      tabBarTheme: _tabBarTheme,
      bottomNavigationBarTheme: _bottomAppBarTheme,
      chipTheme: _chipTheme,
      datePickerTheme: _datePickerThemeData,
      timePickerTheme: _timePickerThemeData,
      filledButtonTheme: _filledButtonTheme,
      navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: AppColors.white,
        indicatorColor: AppColors.secondary,
      ),
      useMaterial3: true,
      sliderTheme: _sliderTheme,
      radioTheme: RadioThemeData(
          fillColor: WidgetStateProperty.resolveWith(
              (states) => AppColors.darkPurple)),
      checkboxTheme: CheckboxThemeData(
          checkColor: WidgetStateProperty.resolveWith(
              (states) => AppColors.textPrimary),
          fillColor:
              WidgetStateProperty.resolveWith((states) => AppColors.white),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
      popupMenuTheme: PopupMenuThemeData(
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.sm),
        ),
        labelTextStyle: WidgetStateProperty.resolveWith(
            (states) => _textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary2,
                )),
        textStyle: _textTheme.bodyMedium?.copyWith(
          color: AppColors.textSecondary2,
        ),
      ), dialogTheme: DialogThemeData(backgroundColor: _backgroundColor),
    );
  }

  static ColorScheme get _colorScheme {
    return ColorScheme.fromSeed(
      brightness: Brightness.dark,
      secondary: AppColors.secondary1,
      background: _backgroundColor,
      seedColor: Colors.blue,
    );
  }

  static SliderThemeData get _sliderTheme {
    return SliderThemeData(
      activeTrackColor: AppColors.lightTurquoise,
      thumbColor: AppColors.white,
      trackHeight: 40,
      valueIndicatorColor: AppColors.darkPurple,
      showValueIndicator: ShowValueIndicator.always,
      inactiveTrackColor: AppColors.transparent,
      inactiveTickMarkColor: AppColors.transparent,
      activeTickMarkColor: AppColors.transparent,
      valueIndicatorShape: const RectangularSliderValueIndicatorShape(),
      valueIndicatorTextStyle: UITextStyle.subtitle2.copyWith(
        color: AppColors.white,
        fontSize: 20.sp,
        fontWeight: AppFontWeight.bold,
      ),
    );
  }

  static SnackBarThemeData get _snackBarTheme {
    return SnackBarThemeData(
      contentTextStyle: UITextStyle.bodyText1.copyWith(
        color: AppColors.white,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.sm),
      ),
      actionTextColor: AppColors.lightBlue.shade300,
      backgroundColor: AppColors.darkPurple,
      elevation: 4,
      behavior: SnackBarBehavior.floating,
    );
  }

  static Color get _backgroundColor => AppColors.backgroundColor;

  static AppBarTheme get _appBarTheme {
    return AppBarTheme(
      iconTheme: _iconTheme,
      titleTextStyle: _textTheme.titleLarge,
      elevation: 0,
      toolbarHeight: 64,
      backgroundColor: AppColors.transparent,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  static IconThemeData get _iconTheme {
    return const IconThemeData(
      color: AppColors.darkPurple,
    );
  }

  static DividerThemeData get _dividerTheme {
    return const DividerThemeData(
      color: AppColors.outlineLight,
      space: AppSpacing.lg,
      thickness: AppSpacing.xxxs,
      indent: 0,
      endIndent: 0,
    );
  }

  static TextTheme get _textTheme => uiTextTheme;

  /// The UI text theme based on [UITextStyle].
  static final uiTextTheme = TextTheme(
    titleLarge: UITextStyle.headline6,
    titleMedium: UITextStyle.subtitle1,
    titleSmall: UITextStyle.subtitle2,
    displayLarge: UITextStyle.headline1,
    displayMedium: UITextStyle.headline2,
    displaySmall: UITextStyle.headline3,
    headlineMedium: UITextStyle.headline4,
    headlineSmall: UITextStyle.headline5,
    bodyLarge: UITextStyle.bodyText1,
    bodyMedium: UITextStyle.bodyText2,
    labelLarge: UITextStyle.button,
    bodySmall: UITextStyle.caption,
    labelSmall: UITextStyle.subtitle3,
  );

  static InputDecorationTheme get _inputDecorationTheme {
    return InputDecorationTheme(
      suffixIconColor: AppColors.mediumEmphasisSurface,
      prefixIconColor: AppColors.mediumEmphasisSurface,
      hoverColor: AppColors.inputHover,
      focusColor: AppColors.inputFocused,
      fillColor: AppColors.inputEnabled,
      enabledBorder: _textFieldBorder,
      focusedBorder: _textFieldBorder,
      disabledBorder: _textFieldBorder,
      hintStyle: UITextStyle.bodyText1.copyWith(
        color: AppColors.mediumEmphasisSurface,
      ),
      contentPadding: const EdgeInsets.all(AppSpacing.lg),
      border: const UnderlineInputBorder(),
      filled: true,
      isDense: true,
      errorStyle: UITextStyle.caption,
    );
  }

  static ButtonThemeData get _buttonTheme {
    return ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
      alignedDropdown: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.sm),
      ),
    );
  }

  static ElevatedButtonThemeData get _elevatedButtonTheme {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        overlayColor: AppColors.transparent,
        splashFactory: NoSplash.splashFactory,
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
        textStyle: _textTheme.labelLarge,
        backgroundColor: AppColors.blue,
      ),
    );
  }

  static TextStyle? get byteButtonTextStyle => _textTheme.labelLarge?.copyWith(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.darkPurple,
      );

  static ElevatedButtonThemeData get elevatedButtonThemeByte {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(329.w, 58.h),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(60)),
        ),
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
        textStyle: byteButtonTextStyle,
        backgroundColor: AppColors.limeLight,
      ),
    );
  }

  static FilledButtonThemeData get _filledButtonTheme {
    return FilledButtonThemeData(
      style: FilledButton.styleFrom(
        fixedSize: Size(329.w, 90.h),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
        textStyle: _textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w900,
          fontSize: 20.sp,
        ),
        backgroundColor: AppColors.lightTurquoise,
        disabledBackgroundColor: AppColors.lightTurquoise.withOpacity(0.25),
      ),
    );
  }

  static TextButtonThemeData get _textButtonTheme {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: _textTheme.labelLarge?.copyWith(
          fontWeight: AppFontWeight.light,
        ),
        foregroundColor: AppColors.darkPurple,
      ),
    );
  }

  static BottomSheetThemeData get _bottomSheetTheme {
    return const BottomSheetThemeData(
      backgroundColor: AppColors.white,
      elevation: 0,
      // clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSpacing.lg),
          topRight: Radius.circular(AppSpacing.lg),
        ),
      ),
    );
  }

  static ListTileThemeData get _listTileTheme {
    return const ListTileThemeData(
      iconColor: AppColors.onBackground,
      horizontalTitleGap: 0,
      contentPadding: EdgeInsets.all(AppSpacing.sm),
    );
  }

  static SwitchThemeData get _switchTheme {
    return SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.darkAqua;
        }
        return AppColors.eerieBlack;
      }),
      trackColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primaryContainer;
        }
        return AppColors.paleSky;
      }),
    );
  }

  static ProgressIndicatorThemeData get _progressIndicatorTheme {
    return const ProgressIndicatorThemeData(
      color: AppColors.darkAqua,
      circularTrackColor: AppColors.borderOutline,
    );
  }

  static TabBarTheme get _tabBarTheme {
    return TabBarTheme(
      labelStyle:
          _textTheme.bodyMedium?.copyWith(color: AppColors.ming, fontSize: 12),
      labelPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xxxs + AppSpacing.xs,
        vertical: AppSpacing.xxxs + AppSpacing.xs,
      ),
      unselectedLabelStyle: _textTheme.bodyMedium
          ?.copyWith(color: AppColors.unSelectedLabel, fontSize: 12),
      unselectedLabelColor: AppColors.unSelectedLabel,
      indicator: const UnderlineTabIndicator(
        borderSide: BorderSide(
          color: AppColors.transparent,
        ),
      ),
      indicatorSize: TabBarIndicatorSize.tab,
      splashFactory: NoSplash.splashFactory,
    );
  }
}

InputBorder get _textFieldBorder => const UnderlineInputBorder(
      borderSide: BorderSide(
        width: 1.5,
        color: AppColors.darkAqua,
      ),
    );

BottomNavigationBarThemeData get _bottomAppBarTheme {
  return BottomNavigationBarThemeData(
    backgroundColor: AppColors.darkBackground,
    selectedItemColor: AppColors.white,
    unselectedItemColor: AppColors.white.withOpacity(0.74),
    elevation: 0,
  );
}

ChipThemeData get _chipTheme {
  return const ChipThemeData(
    backgroundColor: AppColors.transparent,
  );
}

DatePickerThemeData get _datePickerThemeData {
  return const DatePickerThemeData(
      backgroundColor: AppColors.primary,
      dividerColor: AppColors.secondary,
      headerBackgroundColor: AppColors.transparent,
      confirmButtonStyle: ButtonStyle(
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            color: AppColors.white,
          ),
        ),
        backgroundColor: WidgetStatePropertyAll(AppColors.secondary),
      ),
      cancelButtonStyle: ButtonStyle(
          textStyle: WidgetStatePropertyAll(TextStyle(color: AppColors.white)),
          backgroundColor: WidgetStatePropertyAll(AppColors.secondary)));
}

TimePickerThemeData get _timePickerThemeData {
  return const TimePickerThemeData(
      backgroundColor: AppColors.primary,
      dayPeriodColor: AppColors.secondary,
      hourMinuteColor: AppColors.secondary,
      helpTextStyle: TextStyle(color: AppColors.secondary),
      confirmButtonStyle: ButtonStyle(
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            color: AppColors.white,
          ),
        ),
        backgroundColor: WidgetStatePropertyAll(AppColors.secondary),
      ),
      cancelButtonStyle: ButtonStyle(
          textStyle: WidgetStatePropertyAll(TextStyle(color: AppColors.white)),
          backgroundColor: WidgetStatePropertyAll(AppColors.secondary)));
}

/// {@template app_dark_theme}
/// Dark Mode App [ThemeData].
/// {@endtemplate}
class AppDarkTheme extends AppTheme {
  /// {@macro app_dark_theme}
  const AppDarkTheme();

  @override
  ColorScheme get _colorScheme {
    return const ColorScheme.dark().copyWith(
      primary: AppColors.white,
      secondary: AppColors.secondary1,
      surface: AppColors.grey.shade900,
    );
  }

  @override
  SnackBarThemeData get _snackBarTheme {
    return SnackBarThemeData(
      contentTextStyle: UITextStyle.bodyText1.copyWith(
        color: AppColors.darkPurple,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.sm),
      ),
      actionTextColor: AppColors.lightBlue.shade300,
      backgroundColor: AppColors.grey.shade300,
      elevation: 4,
      behavior: SnackBarBehavior.floating,
    );
  }

  @override
  TextButtonThemeData get _textButtonTheme {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: theme.textTheme.labelLarge?.copyWith(
          fontWeight: AppFontWeight.light,
        ),
        foregroundColor: AppColors.white,
      ),
    );
  }

  // ignore: unused_element
  @override
  DividerThemeData get _dividerTheme {
    return const DividerThemeData(
      color: AppColors.onBackground,
      space: AppSpacing.lg,
      thickness: AppSpacing.xxxs,
      indent: AppSpacing.lg,
      endIndent: AppSpacing.lg,
    );
  }
}
