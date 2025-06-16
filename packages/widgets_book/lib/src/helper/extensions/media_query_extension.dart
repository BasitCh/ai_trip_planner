import 'dart:math';

import 'package:flutter/material.dart';
import 'package:widgets_book/src/typography/app_text_styles.dart';

extension MediaQueryValues on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  double get viewPaddingTop => MediaQuery.of(this).viewPadding.top;

  bool isTablet() {
    final size = MediaQuery.of(this).size;
    final diagonal =
        sqrt((size.width * size.width) + (size.height * size.height));
    final isTablet = diagonal > 1100.0;
    return isTablet;
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
    String message,
  {
    int? milliseconds,
  }
  ) =>
      ScaffoldMessenger.of(this).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(this).colorScheme.surface,
          duration: Duration(milliseconds: milliseconds??1500),
          content: Text(
            message,
            overflow: TextOverflow.visible,
            textAlign: TextAlign.center,
            style: UITextStyle.subtitle2,
          ),
        ),
      );
}
