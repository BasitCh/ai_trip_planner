import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// {@template app_back_button}
/// IconButton displayed in the application.
/// Navigates back when is pressed.
/// {@endtemplate}

class AppBackButton extends StatelessWidget {
  /// Creates a default instance of [AppBackButton].
  const AppBackButton({
    Key? key,
    VoidCallback? onPressed,
    Widget? child,
  }) : this._(key: key, onPressed: onPressed, child: child);

  /// Creates a light instance of [AppBackButton].
  const AppBackButton.light({
    Key? key,
    VoidCallback? onPressed,
  }) : this._(
          key: key,
          onPressed: onPressed,
        );

  /// {@macro app_back_button}
  const AppBackButton._({this.onPressed, this.child, super.key});

  /// Called when the back button has been tapped.
  /// Defaults to `Navigator.of(context).pop()`
  final VoidCallback? onPressed;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed ?? () => Navigator.of(context).pop(),
      child: Container(
        width: 32.h,
        height: 32.h,
        decoration: BoxDecoration(
          color: Colors.white, // background color of the container
          borderRadius: BorderRadius.circular(35),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1F4B545A), // Shadow color with 12% opacity
              offset: Offset(0, 24), // Horizontal and vertical offset
              blurRadius: 35, // Blur radius
            ),
          ],
        ),
        child: child ?? const Icon(
          Icons.arrow_back,
          size: 16,
        ),
      ),
    );
  }
}
