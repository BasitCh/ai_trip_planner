import 'package:flutter/material.dart';

class FadeAnimation extends StatelessWidget {
  const FadeAnimation({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      builder: (BuildContext context, double opacity, Widget? child) {
        return Opacity(
          opacity: opacity,
          child: child,
        );
      },
      duration: const Duration(
        milliseconds: 1500,
      ),
      child: child,
    );
  }
}
