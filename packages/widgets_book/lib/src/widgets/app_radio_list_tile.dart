import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:widgets_book/widgets_book.dart';

class AppRadioListTile<T> extends StatelessWidget {
  const AppRadioListTile({
    required this.value,
    required this.groupValue,
    super.key,
    this.title,
    this.subtitle,
    this.isSelected = false,
    this.onChanged,
    this.imageUrl,
  });

  final T value;
  final T? groupValue;
  final void Function(T?)? onChanged;
  final String? title;
  final String? subtitle;
  final bool isSelected;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return RadioListTile<T>(
      controlAffinity: ListTileControlAffinity.trailing,
      contentPadding: const EdgeInsets.only(left: 10, top: 8, bottom: 8),
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      activeColor: AppColors.limeLight,
      title: Row(
        children: [
          if (imageUrl != null) ...[
            Container(
                padding: EdgeInsets.symmetric(vertical: 5.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: SvgPicture.asset(
                    imageUrl!,
                    width: 30.h,
                    height: 25.h,
                    fit: BoxFit.cover,
                    package: 'widgets_book',
                  ),
                ),),
            // CircleAvatar(
            //   backgroundColor: AppColors.pastelGrey,
            //   backgroundImage: AssetImage(
            //     imageUrl!,
            //
            //   ),
            // ),
            Gap(12.h),
          ],
          if (subtitle != null)
            Container(
              padding: const EdgeInsets.only(top: 1),
              child: StandardText.subtitle2(
                title ?? '',
                fontWeight: AppFontWeight.semiBold,
                fontSize: 16.sp,
              ),
            )
          else
            StandardText.subtitle2(
              title ?? '',
              fontWeight: AppFontWeight.semiBold,
              fontSize: 16.sp,
            ),
        ],
      ),
      subtitle: subtitle != null
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Gap(38.h),
                StandardText.subtitle2(
                  subtitle!,
                  fontSize: 9,
                  color: AppColors.greyText,
                  height: .05,
                ),
              ],
            )
          : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: isSelected ? AppColors.darkPurple : AppColors.interfaceGrey,
        ),
      ),
    );
  }
}
