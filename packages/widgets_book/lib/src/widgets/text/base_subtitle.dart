import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class BaseSubtitle extends StatelessWidget {
  const BaseSubtitle({
    required this.text,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return StandardText.subtitle2(
      text,
      letterSpacing: -0.4,
    );
  }
}
