import 'package:flutter/material.dart';
import 'package:widgets_book/src/colors/app_colors.dart';

class AppCheckBox extends StatelessWidget {
  const AppCheckBox({
    super.key,
    this.value,
    this.onChanged,
    this.activeColor = AppColors.secondary,
    this.checkColor = AppColors.white,
    this.tristate = true,
    this.borderSide = const BorderSide(
      width: 2,
      color: AppColors.textGrey,
    ),
    this.outlinedBorder = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  });

  /// Called when the value of the checkbox should change.
  final ValueChanged<bool?>? onChanged;

  /// When [tristate] is true, a value of null corresponds to the mixed state.
  final bool? value;

  final Color? activeColor;

  final Color? checkColor;

  final BorderSide? borderSide;

  final OutlinedBorder outlinedBorder;

  final bool tristate;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: onChanged,
      tristate: tristate,
      activeColor: activeColor,
      checkColor: checkColor,
      fillColor: WidgetStateProperty.all(activeColor),
      side: borderSide,
      shape: outlinedBorder,
    );
  }
}
