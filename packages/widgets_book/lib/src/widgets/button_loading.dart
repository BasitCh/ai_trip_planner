import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class AppButtonLoading extends StatelessWidget {
  const AppButtonLoading({
    super.key,
    this.color,
  });

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.h,
      width: 30.h,
      padding: const EdgeInsets.all(6),
      child: CircularProgressIndicator.adaptive(
        valueColor: AlwaysStoppedAnimation<Color?>(color??AppColors.white),
      ),
    );
  }
}
