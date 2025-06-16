import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:widgets_book/widgets_book.dart';

class TopText extends StatelessWidget {
  const TopText({super.key, this.title, this.subTitle});
  final String? title;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title??'Where do you wish to go?',
          style: titleMediumSaira?.copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.w700,
            fontSize: 20.sp,
          ),
        ),
        Gap(6.h),
        Text(
          subTitle??'Enter a destination, and our system will generate a \nsuggested Trip Plan.',
          textAlign: TextAlign.center,
          style: titleXSmallWhite?.copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }
}
