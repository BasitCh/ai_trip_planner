import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class AppShaderMask extends StatelessWidget {
  const AppShaderMask({super.key,this.text,this.fontSize});
  final String? text;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [
          AppColors.black,
          AppColors.darkGrey.withOpacity(.6)
        ], // Gradient colors
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(bounds),
      child: Text(text??localizations.login_register_text,
          style: TextStyle(
              fontSize: fontSize??26,
              color: AppColors.darkGrey,
              fontWeight: FontWeight.w700,
              fontFamily: FontFamily.saira)),
    );
  }
}
