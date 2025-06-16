import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:widgets_book/widgets_book.dart';

class DeleteCollectionPopup extends StatelessWidget {
  const DeleteCollectionPopup({required this.onCancel, required this.onConfirm, super.key});
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Assets.icons.icDeleteBlack.svg(),

            Gap(14.h),

            // 📝 Title
            Text('Delete list?', style: titleMediumSair),

            const SizedBox(height: 12),

            // 📃 Subtext
            Text('Are you sure you want to delete\nthe list',
                textAlign: TextAlign.center,
                style: titleXSmall?.copyWith(
                    color: AppColors.textColorGreyNew, letterSpacing: 0.25)),

            const SizedBox(height: 24),

            AppButton.lightRed(
              onPressed: onConfirm,
              child: Text('Confirm', style: buttonStyle),
            ),

            Gap(5.h),

            TextButton(
              onPressed: onCancel,
              child: Text('Cancel',
                  style: buttonStyle?.copyWith(color: AppColors.textPrimary)),
            ),
          ],
        ),
      ),
    );
  }
}
