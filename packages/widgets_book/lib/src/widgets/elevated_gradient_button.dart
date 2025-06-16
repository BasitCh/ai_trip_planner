import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class ElevatedGradientButton extends StatelessWidget {
  const ElevatedGradientButton({
    required this.colors,
    required this.text,
    this.textColor,
    super.key,
  });
  final String text;
  final List<Color> colors;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 30,
        right: 30,
      ),
      child: Card(
        elevation: 4,
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: colors,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: textColor ?? AppColors.white,
                    fontSize: 16,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
