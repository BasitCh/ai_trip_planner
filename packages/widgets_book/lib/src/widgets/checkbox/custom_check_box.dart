import 'package:flutter/material.dart';

import 'package:widgets_book/widgets_book.dart';

class CustomCheckbox extends StatelessWidget {
  const CustomCheckbox({required this.value, required this.onChanged, this.checkColor, this.color, this.borderColor, super.key});

  final bool value;
  final ValueChanged<bool?> onChanged;
  final Color? color;
  final Color? checkColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: borderColor ?? (value ? AppColors.textPrimary : AppColors.black600), width: 1.5),
          borderRadius: BorderRadius.circular(4),
        ),
        width: 20,
        height: 20,
        child: value ? Icon(Icons.check, size: 14, color: checkColor??AppColors.textPrimary) : null,
      ),
    );
  }
}
