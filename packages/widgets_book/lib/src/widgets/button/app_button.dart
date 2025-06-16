import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

/// {@template app_button}
/// Button with text displayed in the application.
/// {@endtemplate}
class AppButton extends StatelessWidget {
  /// {@macro app_button}
  const AppButton._({
    required this.child,
    this.onPressed,
    Color? buttonColor,
    Color? disabledButtonColor,
    Color? foregroundColor,
    Color? disabledForegroundColor,
    BorderSide? borderSide,
    double? elevation,
    TextStyle? textStyle,
    Size? maximumSize,
    Size? minimumSize,
    EdgeInsets? padding,
    double? radius,
    super.key,
  })  : _buttonColor = buttonColor ?? Colors.white,
        _disabledButtonColor = disabledButtonColor ?? AppColors.disabledButton,
        _borderSide = borderSide,
        _foregroundColor = foregroundColor ?? AppColors.darkPurple,
        _disabledForegroundColor =
            disabledForegroundColor ?? AppColors.disabledForeground,
        _elevation = elevation ?? 0,
        _textStyle = textStyle,
        _maximumSize = maximumSize ?? _defaultMaximumSize,
        _minimumSize = minimumSize ?? _defaultMinimumSize,
        _radius = radius ?? 10,
        _padding = padding ?? _defaultPadding;

  /// Filled black button.
  const AppButton.black({
    required Widget child,
    Key? key,
    VoidCallback? onPressed,
    double? elevation,
    TextStyle? textStyle,
  }) : this._(
          key: key,
          onPressed: onPressed,
          buttonColor: AppColors.black,
          child: child,
          foregroundColor: AppColors.white,
          elevation: elevation,
          textStyle: textStyle,
        );

  AppButton.darkGray({
    required Widget child,
    Key? key,
    VoidCallback? onPressed,
    double? elevation,
    TextStyle? textStyle,
  }) : this._(
          key: key,
          onPressed: onPressed,
          buttonColor: AppColors.primary800,
          child: child,
          foregroundColor: AppColors.white,
          radius: 12,
          elevation: elevation,
          textStyle: textStyle,
          minimumSize: Size(double.infinity, 52.h),
          maximumSize: Size(double.infinity, 52.h),
        );

  const AppButton.deepOrangeColor({
    required Widget child,
    Key? key,
    VoidCallback? onPressed,
    double? elevation,
    TextStyle? textStyle,
  }) : this._(
          key: key,
          onPressed: onPressed,
          buttonColor: AppColors.deepOrangeColor,
          child: child,
          foregroundColor: AppColors.white,
          radius: 12,
          elevation: elevation,
          textStyle: textStyle,
        );
  const AppButton.redsmall({
    required Widget child,
    Key? key,
    VoidCallback? onPressed,
    double? elevation,
    TextStyle? textStyle,
  }) : this._(
          key: key,
          onPressed: onPressed,
          buttonColor: AppColors.red26,
          child: child,
          foregroundColor: AppColors.white,
          radius: 12,
          elevation: elevation,
          textStyle: textStyle,
        );
  const AppButton.smallGreen({
    required Widget child,
    Key? key,
    VoidCallback? onPressed,
    double? elevation,
    TextStyle? textStyle,
  }) : this._(
          key: key,
          onPressed: onPressed,
          buttonColor: AppColors.green,
          child: child,
          foregroundColor: AppColors.white,
          radius: 12,
          elevation: elevation,
          textStyle: textStyle,
          minimumSize: _smallMinimumSize,
          maximumSize: _smallMaximumSize,
          padding: _smallPadding,
        );

  const AppButton.withParameters({
    required Widget child,
    Key? key,
    VoidCallback? onPressed,
    double? elevation,
    TextStyle? textStyle,
    bool disabled = false,
    Color? buttonColor,
    Color? foregroundColor,
  }) : this._(
          key: key,
          onPressed: onPressed,
          buttonColor: !disabled
              ? buttonColor ?? AppColors.splashElementColor
              : AppColors.primary800,
          child: child,
          foregroundColor: !disabled
              ? foregroundColor ?? AppColors.splashElementColor
              : AppColors.primary800,
          elevation: elevation,
          textStyle: textStyle,
          disabledButtonColor: AppColors.gray,
        );

  const AppButton.withParametersSmall({
    required Widget child,
    Key? key,
    VoidCallback? onPressed,
    double? elevation,
    TextStyle? textStyle,
    bool disabled = false,
    Color? buttonColor,
    Color? foregroundColor,
  }) : this._(
          key: key,
          onPressed: onPressed,
          buttonColor: !disabled
              ? buttonColor ?? AppColors.splashElementColor
              : AppColors.primary800,
          child: child,
          foregroundColor: !disabled
              ? foregroundColor ?? AppColors.splashElementColor
              : AppColors.primary800,
          elevation: elevation,
          textStyle: textStyle,
          disabledButtonColor: AppColors.gray,
          minimumSize: _smallMinimumSize,
          maximumSize: _smallMaximumSize,
        );

  /// Filled blue dress button.
  const AppButton.blueDress({
    required Widget child,
    Key? key,
    VoidCallback? onPressed,
    double? elevation,
    TextStyle? textStyle,
  }) : this._(
          key: key,
          onPressed: onPressed,
          buttonColor: AppColors.blueDress,
          child: child,
          foregroundColor: AppColors.white,
          elevation: elevation,
          textStyle: textStyle,
        );

  const AppButton.red({
    required Widget child,
    Key? key,
    VoidCallback? onPressed,
    double? elevation,
    TextStyle? textStyle,
    double? radius,
    EdgeInsets? padding,
  }) : this._(
          key: key,
          onPressed: onPressed,
          buttonColor: AppColors.lightRed,
          child: child,
          foregroundColor: AppColors.lightRed,
          elevation: elevation,
          textStyle: textStyle,
          radius: radius,
          padding: padding,
        );
  const AppButton.lightRed({
    required Widget child,
    Key? key,
    VoidCallback? onPressed,
    double? elevation,
    TextStyle? textStyle,
    double? radius,
    EdgeInsets? padding,
  }) : this._(
    key: key,
    onPressed: onPressed,
    buttonColor: AppColors.primaryNormal,
    child: child,
    foregroundColor: AppColors.primaryNormal,
    elevation: elevation,
    textStyle: textStyle,
    radius: radius??30,
    padding: padding,
  );
  /// Filled crystal blue button.
  const AppButton.crystalBlue({
    required Widget child,
    Key? key,
    VoidCallback? onPressed,
    double? elevation,
    TextStyle? textStyle,
  }) : this._(
          key: key,
          onPressed: onPressed,
          buttonColor: AppColors.crystalBlue,
          child: child,
          foregroundColor: AppColors.white,
          elevation: elevation,
          textStyle: textStyle,
        );

  const AppButton.darkPurple({
    required Widget child,
    Key? key,
    VoidCallback? onPressed,
    double? elevation,
    TextStyle? textStyle,
    bool disabled = false,
  }) : this._(
          key: key,
          onPressed: onPressed,
          buttonColor:
              !disabled ? AppColors.splashElementColor : AppColors.primary800,
          child: child,
          foregroundColor:
              !disabled ? AppColors.splashElementColor : AppColors.primary800,
          elevation: elevation,
          textStyle: textStyle,
          disabledButtonColor: AppColors.gray,
        );

  const AppButton.darkPurpleSmall({
    required Widget child,
    Key? key,
    VoidCallback? onPressed,
    double? elevation,
    TextStyle? textStyle,
    bool disabled = false,
    Size? maximumSize,
    Size? minimumSize,
  }) : this._(
          key: key,
          onPressed: onPressed,
          buttonColor:
              !disabled ? AppColors.splashElementColor : AppColors.primary800,
          child: child,
          foregroundColor:
              !disabled ? AppColors.splashElementColor : AppColors.primary800,
          elevation: elevation,
          textStyle: textStyle,
          disabledButtonColor: AppColors.gray,
          minimumSize: minimumSize ?? _smallMinimumSize,
          maximumSize: maximumSize ?? _smallMaximumSize,
          padding: _smallPadding,
        );

  const AppButton.outlinedDarkPurple({
    required Widget child,
    Key? key,
    VoidCallback? onPressed,
    double? elevation,
    TextStyle? textStyle,
    double? borderRadius
  }) : this._(
          key: key,
          onPressed: onPressed,
          buttonColor: AppColors.transparent,
          borderSide: const BorderSide(color: AppColors.darkPurple),
          child: child,
          elevation: elevation,
          textStyle: textStyle,
    radius:borderRadius,
          disabledButtonColor: AppColors.gray,
        );
  const AppButton.outlinePrimaryNormal({
    required Widget child,
    Key? key,
    VoidCallback? onPressed,
    double? elevation,
    double? borderRadius,
    TextStyle? textStyle,
  }) : this._(
    key: key,
    onPressed: onPressed,
    buttonColor: AppColors.transparent,
    borderSide: const BorderSide(color: AppColors.primaryNormal),
    radius: borderRadius,
    child: child,
    elevation: elevation,
    textStyle: textStyle,
    disabledButtonColor: AppColors.white,
  );

  const AppButton.outlinedGrey({
    required Widget child,
    Key? key,
    VoidCallback? onPressed,
    double? elevation,
    TextStyle? textStyle,
  }) : this._(
          key: key,
          onPressed: onPressed,
          buttonColor: AppColors.transparent,
          borderSide: const BorderSide(color: AppColors.darkGreyColor),
          radius: 8,
          child: child,
          elevation: elevation,
          textStyle: textStyle,
          disabledButtonColor: AppColors.gray,
        );
  const AppButton.outlinedBlack({
    required Widget child,
    Key? key,
    VoidCallback? onPressed,
    double? elevation,
    double? radius,
    TextStyle? textStyle,
  }) : this._(
    key: key,
    onPressed: onPressed,
    buttonColor: AppColors.transparent,
    borderSide: const BorderSide(color: AppColors.black),
    radius: 30,
    child: child,
    elevation: elevation,
    textStyle: textStyle,
    disabledButtonColor: AppColors.gray,
  );
   AppButton.outlinedDarkGrayish({
    required Widget child,
    Key? key,
    double? radius,
    VoidCallback? onPressed,
    double? elevation,
    TextStyle? textStyle,
  }) : this._(
    key: key,
    onPressed: onPressed,
    buttonColor: AppColors.transparent,
    borderSide:  BorderSide(color: AppColors.textTertiary5.withOpacity(0.50)),
    radius: radius??30,
    child: child,
    elevation: elevation,
    textStyle: textStyle,
    disabledButtonColor: AppColors.textTertiary5,
  );

  const AppButton.lightGray({
    required Widget child,
    Key? key,
    VoidCallback? onPressed,
    double? elevation,
    TextStyle? textStyle,
    bool disabled = false,
    Size? maximumSize,
    Size? minimumSize,
  }) : this._(
          key: key,
          onPressed: onPressed,
          buttonColor: !disabled ? AppColors.lightGray : AppColors.primary800,
          child: child,
          foregroundColor:
              !disabled ? AppColors.lightGray : AppColors.primary800,
          elevation: elevation,
          textStyle: textStyle,
          disabledButtonColor: AppColors.gray,
          maximumSize: maximumSize,
          minimumSize: minimumSize,
        );

  /// Filled red wine button.
  const AppButton.green({
    required Widget child,
    Key? key,
    VoidCallback? onPressed,
    double? elevation,
    TextStyle? textStyle,
    bool disabled = false,
  }) : this._(
          key: key,
          onPressed: onPressed,
          buttonColor: !disabled ? AppColors.green : AppColors.primary800,
          child: child,
          foregroundColor: !disabled ? AppColors.green : AppColors.primary800,
          elevation: elevation,
          textStyle: textStyle,
          disabledButtonColor: AppColors.gray,
        );

  const AppButton.redish({
    required Widget child,
    Key? key,
    VoidCallback? onPressed,
    double? elevation,
    TextStyle? textStyle,
    bool disabled = false,
  }) : this._(
          key: key,
          onPressed: onPressed,
          buttonColor: !disabled ? AppColors.redish : AppColors.primary800,
          child: child,
          foregroundColor: !disabled ? AppColors.redish : AppColors.primary800,
          elevation: elevation,
          textStyle: textStyle,
          disabledButtonColor: AppColors.gray,
          radius: 0,
        );

  const AppButton.white({
    required Widget child,
    Key? key,
    VoidCallback? onPressed,
    double? elevation,
    TextStyle? textStyle,
    double? radius,
    bool disabled = false,
  }) : this._(
          key: key,
          onPressed: onPressed,
          buttonColor: !disabled ? AppColors.white : AppColors.primary800,
          child: child,
          foregroundColor: !disabled ? AppColors.green : AppColors.primary800,
          elevation: elevation,
          textStyle: textStyle,
          radius: radius??12,
          disabledButtonColor: AppColors.gray,
        );

  const AppButton.grey({
    required Widget child,
    Key? key,
    VoidCallback? onPressed,
    double? elevation,
    TextStyle? textStyle,
    bool disabled = false,
  }) : this._(
          key: key,
          onPressed: onPressed,
          buttonColor:
              !disabled ? AppColors.whiteOpacity800 : AppColors.primary800,
          child: child,
          foregroundColor:
              !disabled ? AppColors.whiteOpacity800 : AppColors.primary800,
          elevation: elevation,
          textStyle: textStyle,
          disabledButtonColor: AppColors.gray,
        );

  const AppButton.grayishBlue({
    required Widget child,
    Key? key,
    VoidCallback? onPressed,
    double? elevation,
    TextStyle? textStyle,
  }) : this._(
          key: key,
          onPressed: onPressed,
          buttonColor: AppColors.grayishBlue,
          child: child,
          foregroundColor: AppColors.grayishBlue,
          elevation: elevation,
          textStyle: textStyle,
          disabledButtonColor: AppColors.gray,
        );

  const AppButton.lightGreen({
    required Widget child,
    Key? key,
    VoidCallback? onPressed,
    double? elevation,
    TextStyle? textStyle,
  }) : this._(
          key: key,
          onPressed: onPressed,
          buttonColor: AppColors.lightGreen,
          child: child,
          foregroundColor: AppColors.lightGreen,
          elevation: elevation,
          textStyle: textStyle,
          disabledButtonColor: AppColors.lightGreen,
        );

  // Filled dark red button
  const AppButton.darkRed({
    required Widget child,
    Key? key,
    VoidCallback? onPressed,
    double? elevation,
    TextStyle? textStyle,
    double? radius,
  }) : this._(
          key: key,
          onPressed: onPressed,
          buttonColor: AppColors.accent,
          child: child,
          foregroundColor: AppColors.white800,
          elevation: elevation,
          textStyle: textStyle,
          radius: radius ?? 8,
        );

  /// Filled secondary button.
  const AppButton.secondary({
    required Widget child,
    Key? key,
    VoidCallback? onPressed,
    double? elevation,
    TextStyle? textStyle,
    Color? disabledButtonColor,
    Size? minSize,
    Size? maxSize,
  }) : this._(
          key: key,
          onPressed: onPressed,
          buttonColor: AppColors.secondary1,
          child: child,
          foregroundColor: AppColors.white,
          disabledButtonColor: disabledButtonColor ?? AppColors.disabledSurface,
          elevation: elevation,
          textStyle: textStyle,
          padding: _smallPadding,
          maximumSize: maxSize ?? _smallMaximumSize,
          minimumSize: minSize ?? _smallMinimumSize,
        );

  /// Filled dark aqua button.
  const AppButton.darkAqua({
    required Widget child,
    Key? key,
    VoidCallback? onPressed,
    double? elevation,
    TextStyle? textStyle,
  }) : this._(
          key: key,
          onPressed: onPressed,
          buttonColor: AppColors.darkAqua,
          child: child,
          foregroundColor: AppColors.white,
          elevation: elevation,
          textStyle: textStyle,
        );

  /// Outlined white button.
  const AppButton.outlinedWhite({
    required Widget child,
    Key? key,
    VoidCallback? onPressed,
    double? elevation,
    TextStyle? textStyle,
    Size? minSize,
    Size? maxSize,
  }) : this._(
          key: key,
          onPressed: onPressed,
          child: child,
          buttonColor: AppColors.transparent,
          borderSide: const BorderSide(
            color: AppColors.white,
            width: 2,
          ),
          padding: const EdgeInsets.only(),
          elevation: elevation,
          foregroundColor: AppColors.lightBlack,
          textStyle: textStyle,
          maximumSize: maxSize,
          minimumSize: minSize,
        );

  /// Outlined transparent dark aqua button.
  const AppButton.outlinedTransparentDarkAqua({
    required Widget child,
    Key? key,
    VoidCallback? onPressed,
    double? elevation,
    TextStyle? textStyle,
  }) : this._(
          key: key,
          onPressed: onPressed,
          child: child,
          buttonColor: AppColors.transparent,
          borderSide: const BorderSide(
            color: AppColors.paleSky,
          ),
          elevation: elevation,
          foregroundColor: AppColors.darkAqua,
          textStyle: textStyle,
        );

  const AppButton.outlinedMidnightBlue({
    required Widget child,
    Key? key,
    VoidCallback? onPressed,
    double? elevation,
    TextStyle? textStyle,
  }) : this._(
          key: key,
          onPressed: onPressed,
          child: child,
          buttonColor: AppColors.transparent,
          borderSide: const BorderSide(
            color: AppColors.midnightBlue,
          ),
          radius: 12,
          elevation: elevation,
          foregroundColor: AppColors.midnightBlue,
          textStyle: textStyle,
        );

  /// Outlined transparent white button.
  const AppButton.outlinedTransparentWhite({
    required Widget child,
    Key? key,
    VoidCallback? onPressed,
    double? elevation,
    TextStyle? textStyle,
  }) : this._(
          key: key,
          onPressed: onPressed,
          child: child,
          buttonColor: AppColors.transparent,
          borderSide: const BorderSide(
            color: AppColors.white,
          ),
          elevation: elevation,
          foregroundColor: AppColors.white,
          textStyle: textStyle,
        );

  /// Filled transparent dark aqua button.
  const AppButton.transparentDarkAqua({
    required Widget child,
    Key? key,
    VoidCallback? onPressed,
    double? elevation,
    TextStyle? textStyle,
  }) : this._(
          key: key,
          onPressed: onPressed,
          child: child,
          buttonColor: AppColors.transparent,
          elevation: elevation,
          foregroundColor: AppColors.darkAqua,
          textStyle: textStyle,
        );

  const AppButton.outlineGreySmall({
    required Widget child,
    Key? key,
    VoidCallback? onPressed,
    double? elevation,
    TextStyle? textStyle,
    Size? minSize,
    Size? maxSize,
  }) : this._(
    key: key,
    onPressed: onPressed,
    child: child,
    buttonColor: AppColors.transparent,
    borderSide: const BorderSide(
      color: AppColors.buttonBorderColor,
      width: 1,
    ),
    padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 6),
    elevation: elevation,
    foregroundColor: AppColors.white,
    textStyle: textStyle,
    radius: 30,
    maximumSize: _smallMaximumSize,
    minimumSize: _xSmallMinimumSize,
  );

  /// Filled transparent white button.
  const AppButton.transparentWhite({
    required Widget child,
    Key? key,
    VoidCallback? onPressed,
    double? elevation,
    TextStyle? textStyle,
  }) : this._(
          key: key,
          onPressed: onPressed,
          child: child,
          disabledButtonColor: AppColors.transparent,
          buttonColor: AppColors.transparent,
          elevation: elevation,
          foregroundColor: AppColors.white,
          disabledForegroundColor: AppColors.white,
          textStyle: textStyle,
        );

  /// Filled small red wine blue button.
  const AppButton.smallRedWine({
    required Widget child,
    Key? key,
    VoidCallback? onPressed,
    double? elevation,
  }) : this._(
          key: key,
          onPressed: onPressed,
          buttonColor: AppColors.green,
          child: child,
          foregroundColor: AppColors.white,
          elevation: elevation,
          maximumSize: _smallMaximumSize,
          minimumSize: _smallMinimumSize,
          padding: _smallPadding,
        );

  /// Filled small transparent button.
  const AppButton.smallDarkAqua({
    required Widget child,
    Key? key,
    VoidCallback? onPressed,
    double? elevation,
  }) : this._(
          key: key,
          onPressed: onPressed,
          buttonColor: AppColors.darkAqua,
          child: child,
          foregroundColor: AppColors.white,
          elevation: elevation,
          maximumSize: _smallMaximumSize,
          minimumSize: _smallMinimumSize,
          padding: _smallPadding,
        );

  /// Filled small transparent button.
  const AppButton.smallTransparent({
    required Widget child,
    Key? key,
    VoidCallback? onPressed,
    double? elevation,
  }) : this._(
          key: key,
          onPressed: onPressed,
          buttonColor: AppColors.transparent,
          child: child,
          foregroundColor: AppColors.darkAqua,
          elevation: elevation,
          maximumSize: _smallMaximumSize,
          minimumSize: _smallMinimumSize,
          padding: _smallPadding,
        );

  /// Filled small transparent button.
  const AppButton.smallOutlineTransparent({
    required Widget child,
    Key? key,
    VoidCallback? onPressed,
    double? elevation,
  }) : this._(
          key: key,
          onPressed: onPressed,
          buttonColor: AppColors.transparent,
          child: child,
          borderSide: const BorderSide(
            color: AppColors.paleSky,
          ),
          foregroundColor: AppColors.darkAqua,
          elevation: elevation,
          maximumSize: _smallMaximumSize,
          minimumSize: _smallMinimumSize,
          padding: _smallPadding,
        );

  /// The maximum size of the small variant of the button.
  static const _smallMaximumSize = Size(double.infinity, 56);

  /// The minimum size of the small variant of the button.
  static const _smallMinimumSize = Size(0, 56);
  static const _xSmallMinimumSize = Size(0, 40);

  /// The maximum size of the button.
  static const _defaultMaximumSize = Size(double.infinity, 56);

  /// The minimum size of the button.
  static const _defaultMinimumSize = Size(double.infinity, 56);

  /// The padding of the small variant of the button.
  static const _smallPadding = EdgeInsets.symmetric(horizontal: AppSpacing.lg);

  /// The padding of the the button.
  static const _defaultPadding = EdgeInsets.symmetric(vertical: AppSpacing.sm);

  /// [VoidCallback] called when button is pressed.
  /// Button is disabled when null.
  final VoidCallback? onPressed;

  /// A background color of the button.
  ///
  /// Defaults to [Colors.white].
  final Color _buttonColor;

  /// A disabled background color of the button.
  ///
  /// Defaults to [AppColors.disabledButton].
  final Color? _disabledButtonColor;

  /// Color of the text, icons etc.
  ///
  /// Defaults to [AppColors.darkPurple].
  final Color _foregroundColor;

  /// Color of the disabled text, icons etc.
  ///
  /// Defaults to [AppColors.disabledForeground].
  final Color _disabledForegroundColor;

  /// A border of the button.
  final BorderSide? _borderSide;

  /// Elevation of the button.
  final double _elevation;

  /// [TextStyle] of the button text.
  ///
  /// Defaults to [TextTheme.labelLarge].
  final TextStyle? _textStyle;

  /// The maximum size of the button.
  ///
  /// Defaults to [_defaultMaximumSize].
  final Size _maximumSize;

  /// The minimum size of the button.
  ///
  /// Defaults to [_defaultMinimumSize].
  final Size _minimumSize;

  /// The padding of the button.
  ///
  /// Defaults to [EdgeInsets.zero].
  final EdgeInsets _padding;

  /// [Widget] displayed on the button.
  final Widget child;

  final double _radius;

  @override
  Widget build(BuildContext context) {
    final textStyle = _textStyle ?? Theme.of(context).textTheme.labelLarge;

    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        maximumSize: WidgetStateProperty.all(_maximumSize),
        padding: WidgetStateProperty.all(_padding),
        minimumSize: WidgetStateProperty.all(_minimumSize),
        textStyle: WidgetStateProperty.all(textStyle),
        backgroundColor: onPressed == null
            ? WidgetStateProperty.all(_disabledButtonColor)
            : WidgetStateProperty.all(_buttonColor),
        elevation: WidgetStateProperty.all(_elevation),
        foregroundColor: onPressed == null
            ? WidgetStateProperty.all(_disabledForegroundColor)
            : WidgetStateProperty.all(_foregroundColor),
        side: WidgetStateProperty.all(_borderSide),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_radius),
          ),
        ),
      ),
      child: child,
    );
  }
}
