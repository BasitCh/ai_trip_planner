

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:widgets_book/widgets_book.dart';

class TripPlanHeading extends StatelessWidget {
  const TripPlanHeading({super.key, this.title, this.icon});
  final String? title;
  final Widget? icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title??'Example Prompts ',
            style: titleMediumSaira?.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.w700,
                fontSize: 16.sp
            )),
        Gap(5),
        icon??Assets.icons.icBlub.svg(),
      ],
    );
  }
}
