import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

/// {@template app_switch}
/// Switch with optional leading text displayed in the application.
/// {@endtemplate}
class AppSwitch extends StatelessWidget {
  /// {@macro app_switch}
  const AppSwitch({
    required this.value,
    required this.onChanged,
    this.onText = '',
    this.offText = '',
    super.key,
  });

  /// Text displayed when this switch is set to true.
  ///
  /// Defaults to an empty string.
  final String onText;

  /// Text displayed when this switch is set to false.
  ///
  /// Defaults to an empty string.
  final String offText;

  /// Whether this checkbox is checked.
  final bool value;

  /// Called when the value of the checkbox should change.
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppSpacing.xxs,
      ),
      child: Switch(
        value: value,
        onChanged: onChanged,
        activeTrackColor: AppColors.darkGreenColor,
        inactiveTrackColor: AppColors.inActiveSwitchColor,
        trackOutlineColor: WidgetStateProperty.all(AppColors.transparent),
        activeColor: AppColors.white,
        inactiveThumbColor: AppColors.white,
        thumbIcon: WidgetStateProperty.all(Icon(
          Icons.circle,
          color: AppColors.white,
        )),
      ),
    );
  }
}
