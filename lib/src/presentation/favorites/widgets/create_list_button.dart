import 'package:flutter/material.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:widgets_book/widgets_book.dart';

class CreateListButton extends StatelessWidget {
  const CreateListButton({required this.onCreatePressed, super.key});
  final VoidCallback? onCreatePressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 20, left: 80, right: 80),
      child: SizedBox(
        height: 36,
        child: AppButton.lightRed(
          onPressed: onCreatePressed,
          child: Text(
            'Create New List',
            style: titleMediumSaira?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
