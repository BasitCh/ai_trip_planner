// Reusable Widget: Menu Option
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:widgets_book/widgets_book.dart';

class MenuOption extends StatelessWidget {
  final Widget icon;
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const MenuOption({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: onPressed,
        child: Row(
          children: [
            icon,
            Gap(25.w),
            Text(
              label,
              style: titleMediumSaira?.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.lightBlackText,
                fontSize: 18.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}