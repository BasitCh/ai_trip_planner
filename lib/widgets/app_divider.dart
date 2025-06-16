import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({this.color, super.key});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Divider(color: color ?? AppColors.textTertiary);
  }
}
