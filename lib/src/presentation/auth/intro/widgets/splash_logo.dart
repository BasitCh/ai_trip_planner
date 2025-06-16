import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class SplashLogo extends StatelessWidget {
  const SplashLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SlideInAnimation(
        delayDuration: const Duration(milliseconds: 500),
        child: Container(
            padding: EdgeInsets.only(bottom: 17.h),
            child: Assets.icons.splashLogo
                .svg(width: 255.h, height: 70.h, fit: BoxFit.scaleDown)));
  }
}
