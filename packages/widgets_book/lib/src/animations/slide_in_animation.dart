import 'package:flutter/material.dart';

class SlideInAnimation extends StatefulWidget {
  const SlideInAnimation({
    required this.child,
    this.delayDuration,
    super.key,
  });

  final Widget child;
  final Duration? delayDuration;

  @override
  State<SlideInAnimation> createState() => _SlideInAnimationState();
}

class _SlideInAnimationState extends State<SlideInAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation = Tween<Offset>(
      begin: const Offset(0, 1), // Start position (off the screen to the right)
      end: Offset.zero, // End position (on the screen)
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ),);

    // Start the animation
    _startAnimation(_controller,widget.delayDuration);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(position: _animation, child: widget.child);
  }

  Future<void> _startAnimation(AnimationController controller,Duration? delayDuration) async {
    delayDuration!=null? await Future<void>.delayed(delayDuration).then((_)=>_controller.forward()): _controller.forward();
  }
}
