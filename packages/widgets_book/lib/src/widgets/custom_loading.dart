import 'package:flutter/material.dart';

class CustomLoading extends StatefulWidget {
  const CustomLoading({
    super.key,
    this.color,
  });

  final Color? color;

  @override
  State<CustomLoading> createState() => _CustomLoadingState();
}

class _CustomLoadingState extends State<CustomLoading> with TickerProviderStateMixin {
  late AnimationController _animationController;
  final animationDuration = const Duration(milliseconds: 500);

  @override
  void initState() {
    _animationController = AnimationController(
      duration: animationDuration,
      vsync: this,
    );
    animationListener();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _animationController.forward();
    return SizedBox(
      width: 20,
      height: 20,
      child: RotationTransition(
        turns: getTurns(),
        // child: Assets.icons.loader.image(color: widget.color),
      ),
    );
  }

  Animation<double> getTurns() {
    return Tween<double>(begin: 1, end: 0).animate(
      _animationController,
    );
  }

  void animationListener() {
    _animationController.addListener(_checkAnimationStatus);
  }

  void _checkAnimationStatus() {
    if (_animationController.isCompleted) {
      _animationController.repeat();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
