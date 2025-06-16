import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//A flutter plugin for adapting screen and font size.Let your UI display a
// reasonable
// layout on different screen sizes!
class ScreenUtilSetup extends StatelessWidget {
  const ScreenUtilSetup({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        ScreenUtil.init(
          context,
          designSize: const Size(390, 812),
          minTextAdapt: true,
        );
        return child!;
      },
    );
  }
}
