import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class BaseTitle extends StatelessWidget {
  const BaseTitle({
    required this.text,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return StandardText.headline3(
      text,
    );
  }
}
