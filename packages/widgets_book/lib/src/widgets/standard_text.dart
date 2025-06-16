// ignore_for_file: avoid_unused_constructor_parameters

import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class StandardText extends StatelessWidget {
  const StandardText({
    required this.text,
    super.key,
    this.textAlign = TextAlign.center,
    this.fontSize = 14,
    this.color,
    this.fontWeight = FontWeight.w300,
    this.fontStyle = FontStyle.normal,
    this.textDecoration = TextDecoration.none,
    this.style,
    this.maxLines,
    this.overflow,
    this.height,
  });

  factory StandardText.withTheme(
    String text,
    TextStyle theme,
    Color color, {
    TextAlign align = TextAlign.center,
  }) {
    return StandardText(
      text: text,
      style: theme.copyWith(
        color: color,
      ),
      textAlign: align,
    );
  }

  factory StandardText.caption(
    String text, {
    TextAlign align = TextAlign.center,
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
    TextOverflow? overflow,
    int? maxLines,
    TextDecoration? decoration,
    String? fontFamily,
  }) {
    final style = UITextStyle.caption.copyWith(
      fontWeight: fontWeight,
      color: color ?? AppColors.primary,
      fontSize: fontSize,
      decoration: decoration,
      fontFamily: fontFamily,
    );
    return StandardText(
      text: text,
      style: style,
      textAlign: align,
      overflow: overflow,
      maxLines: maxLines,
    );
  }

  // Body
  factory StandardText.body2(
    String text, {
    TextAlign align = TextAlign.start,
    Color? color,
    FontWeight? fontWeight,
    double fontSize = 15,
    TextOverflow? overflow,
    int? maxLines,
    TextDecoration decoration = TextDecoration.none,
  }) {
    final style = UITextStyle.bodyText2.copyWith(
      fontWeight: fontWeight,
      color: color ?? AppColors.primary,
      fontSize: fontSize,
      decoration: decoration,
    );
    return StandardText(
      text: text,
      style: style,
      textAlign: align,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  factory StandardText.body1(
    String text, {
    TextAlign align = TextAlign.start,
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
    TextOverflow? overflow,
    int? maxLines,
    TextDecoration decoration = TextDecoration.none,
  }) {
    final style = UITextStyle.bodyText1.copyWith(
      fontWeight: fontWeight,
      color: color ?? AppColors.primary,
      fontSize: fontSize,
      decoration: decoration,
    );
    return StandardText(
      text: text,
      style: style,
      textAlign: align,
      overflow: overflow,
      maxLines: maxLines,
    );
  }

  // Subtitles
  factory StandardText.subtitle3(
    String text, {
    TextAlign align = TextAlign.start,
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
    TextOverflow? overflow,
    int? maxLines,
    double? letterSpacing,
  }) {
    final style = UITextStyle.subtitle3.copyWith(
      fontWeight: fontWeight,
      color: color ?? AppColors.primary,
      fontSize: fontSize,
      letterSpacing: letterSpacing,
    );
    return StandardText(
      text: text,
      style: style,
      textAlign: align,
      overflow: overflow,
      maxLines: maxLines,
    );
  }

  factory StandardText.subtitle2(
    String text, {
    TextAlign align = TextAlign.start,
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
    TextOverflow? overflow,
    int? maxLines,
    double? letterSpacing,
    double? height,
    String? fontFamily,
  }) {
    final style = UITextStyle.subtitle2.copyWith(
      fontWeight: fontWeight,
      color: color ?? AppColors.primary,
      fontSize: fontSize,
      letterSpacing: letterSpacing,
      height: height,
      fontFamily: fontFamily,
    );
    return StandardText(
      text: text,
      style: style,
      textAlign: align,
      overflow: overflow,
      maxLines: maxLines,
    );
  }

  factory StandardText.subtitle1(
    String text, {
    TextAlign align = TextAlign.start,
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
    TextOverflow? overflow,
    int? maxLines,
    String? fontFamily,
    double? letterSpacing,
  }) {
    final style = UITextStyle.subtitle1.copyWith(
      fontWeight: fontWeight,
      color: color ?? AppColors.primary,
      fontSize: fontSize,
      fontFamily: fontFamily,
      letterSpacing: letterSpacing,
    );
    return StandardText(
      text: text,
      style: style,
      textAlign: align,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  // Headers
  factory StandardText.headline6(
    String text, {
    TextAlign align = TextAlign.center,
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
    int? maxLines,
    TextOverflow overflow = TextOverflow.ellipsis,
  }) {
    final style = UITextStyle.headline6.copyWith(
      fontWeight: fontWeight,
      color: color ?? AppColors.primary,
      fontSize: fontSize,
    );
    return StandardText(
      text: text,
      style: style,
      textAlign: align,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  factory StandardText.headline5(
    String text, {
    TextAlign align = TextAlign.center,
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
    int? maxLines,
    TextOverflow overflow = TextOverflow.ellipsis,
    String? fontFamily = 'Mont',
  }) {
    final style = UITextStyle.headline5.copyWith(
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      color: color ?? AppColors.primary,
      fontSize: fontSize,
    );
    return StandardText(
      text: text,
      style: style,
      textAlign: align,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  factory StandardText.headline4(
    String text, {
    TextAlign align = TextAlign.center,
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
    int? maxLines,
    TextOverflow? overflow,
    TextDecoration? decoration,
  }) {
    final style = UITextStyle.headline4.copyWith(
      fontWeight: fontWeight,
      color: color,
      fontSize: fontSize,
      decoration: decoration,
    );
    return StandardText(
      text: text,
      style: style,
      textAlign: align,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  factory StandardText.headline3(
    String text, {
    TextAlign align = TextAlign.center,
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
    TextOverflow? overflow,
    int? maxLines,
    TextDecoration? decoration,
  }) {
    final style = UITextStyle.headline3.copyWith(
      fontWeight: fontWeight,
      color: color,
      fontSize: fontSize,
      decoration: decoration,
    );
    return StandardText(
      text: text,
      style: style,
      textAlign: align,
      overflow: overflow,
      maxLines: maxLines,
    );
  }

  factory StandardText.headline2(
    String text, {
    TextAlign align = TextAlign.center,
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
  }) {
    final style = UITextStyle.headline2.copyWith(
      fontWeight: fontWeight,
      color: color ?? AppColors.primary,
      fontSize: fontSize,
    );
    return StandardText(text: text, style: style, textAlign: align);
  }

  factory StandardText.headline1(
    String text, {
    TextAlign align = TextAlign.center,
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
    String? fontFamily,
  }) {
    final style = UITextStyle.headline1.copyWith(
      fontWeight: fontWeight,
      color: color ?? AppColors.primary,
      fontFamily: fontFamily ?? FontFamily.saira,
      fontSize: fontSize,
    );
    return StandardText(text: text, style: style, textAlign: align);
  }

  factory StandardText.underline(
    String text, {
    TextAlign align = TextAlign.center,
    Color? color,
    FontWeight? fontWeight,
    TextOverflow overflow = TextOverflow.ellipsis,
    double? fontSize,
    int? maxLines,
  }) {
    final style = UITextStyle.caption.copyWith(
      fontWeight: fontWeight,
      color: color ?? AppColors.primary,
      fontSize: fontSize,
      decoration: TextDecoration.underline,
    );
    return StandardText(
      text: text,
      style: style,
      textAlign: align,
      overflow: overflow,
      maxLines: maxLines,
    );
  }

  factory StandardText.linkUnderline(
    String text, {
    TextAlign align = TextAlign.start,
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
  }) {
    final style = UITextStyle.bodyText1.copyWith(
      color: color ?? AppColors.accent,
      fontWeight: fontWeight,
      decoration: TextDecoration.underline,
      fontSize: fontSize,
    );
    return StandardText(text: text, style: style, textAlign: align);
  }

  // Buttons
  factory StandardText.buttonLarge(
    String text, {
    TextAlign align = TextAlign.center,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    TextDecoration? decoration,
    double? letterSpacing,
    TextOverflow? overflow,
  }) {
    final style = UITextStyle.button.copyWith(
      color: color ?? AppColors.secondary1,
      fontSize: fontSize,
      fontWeight: fontWeight,
      decoration: decoration,
      letterSpacing: letterSpacing,
      overflow: overflow ?? TextOverflow.ellipsis,
    );
    return StandardText(
      text: text,
      style: style,
      textAlign: align,
    );
  }

  factory StandardText.buttonSmall(
    String text, {
    TextAlign align = TextAlign.center,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight = AppFontWeight.medium,
    TextDecoration? decoration,
    double? letterSpacing,
    TextOverflow? overflow,
  }) {
    final style = UITextStyle.subtitle2.copyWith(
      color: color ?? AppColors.secondary1,
      fontSize: fontSize,
      fontWeight: fontWeight,
      decoration: decoration,
      letterSpacing: letterSpacing ?? 0.8,
      overflow: overflow ?? TextOverflow.ellipsis,
    );
    return StandardText(
      text: text,
      style: style,
      textAlign: align,
    );
  }

  final String text;
  final double fontSize;
  final Color? color;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final FontStyle fontStyle;
  final TextDecoration textDecoration;
  final TextStyle? style;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = DefaultTextStyle.of(context);
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow ?? defaultTextStyle.overflow,
      maxLines: maxLines ?? defaultTextStyle.maxLines,
      style: style ??
          TextStyle(
            color: color,
            fontSize: fontSize,
            fontWeight: fontWeight,
            fontStyle: fontStyle,
            decoration: textDecoration,
            fontFamily: 'Mont',
            height: height,
          ),
    );
  }
}
