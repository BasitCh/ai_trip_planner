import 'package:flutter/material.dart';

class ScreenTapDetector extends StatelessWidget {
  const ScreenTapDetector({required this.onTapLeft, required this.onTapRight, required this.child, super.key});

  final VoidCallback? onTapLeft;
  final VoidCallback? onTapRight;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;

        return Stack(
          children: [
            child,
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              width: screenWidth / 2,
              child: GestureDetector(
                onTap: onTapLeft,
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              width: screenWidth / 2,
              child: GestureDetector(
                onTap: onTapRight,
                child: Container(color: Colors.transparent,),
              ),
            ),
          ],
        );
      },
    );
  }
}
