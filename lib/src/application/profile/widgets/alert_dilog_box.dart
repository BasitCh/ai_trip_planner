import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:widgets_book/widgets_book.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;
  final String cancelText;
  final String deleteText;
  final Color deleteColor;
  final EdgeInsetsGeometry? insetPadding;

  const DeleteConfirmationDialog({
    super.key,
    this.title = 'Delete Record?',
    this.content = 'Are you sure you want to \ndelete this item?',
    this.cancelText = 'Cancel',
    this.deleteText = 'Delete',
    this.deleteColor = AppColors.red,
    this.insetPadding,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.all(24.h),
      contentPadding: EdgeInsets.all(24.h),
      title: Text(
        title,
        style: titleMediumSaira?.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
          fontSize: 20,
        ),
        textAlign: TextAlign.center,
      ),
      content: Text(content,
          textAlign: TextAlign.center,
          style: titleMediumSaira?.copyWith(
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
            fontSize: 18,
          )),
      actions: [
        Row(
          children: [
            Expanded(
              flex: 5,
              child: AppButton.outlinedGrey(
                child: Text(
                  cancelText,
                  style: titleMediumSaira?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.darkGreyColor,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
                onPressed: () => Navigator.of(context).pop(false),
              ),
            ),
            Gap(12),
            Expanded(
              flex: 5,
              child: AppButton.redsmall(
                child: Text(
                  deleteText,
                  style:titleMediumSaira?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                    fontSize: 18,
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
