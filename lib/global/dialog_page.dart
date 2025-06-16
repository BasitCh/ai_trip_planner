import 'package:flutter/material.dart';

class DialogPage<T> extends Page<T> {
  const DialogPage({
    required this.builder,
    this.anchorPoint,
    this.barrierColor = Colors.black87,
    this.barrierDismissible = true,
    this.barrierLabel,
    this.useSafeArea = true,
    this.themes,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  });

  final Offset? anchorPoint;
  final Color? barrierColor;
  final bool barrierDismissible;
  final String? barrierLabel;
  final bool useSafeArea;
  final CapturedThemes? themes;
  final WidgetBuilder builder;

  @override
  Route<T> createRoute(BuildContext context) => DialogRoute<T>(
        context: context,
        settings: this,
        builder: (context) => Dialog(
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 40,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          child: builder(context),
        ),
        anchorPoint: anchorPoint,
        barrierDismissible: barrierDismissible,
        barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        useSafeArea: useSafeArea,
        themes: themes,
      );
}
