import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:travel_hero/widgets/custom_switch.dart';
import 'package:widgets_book/widgets_book.dart';

class PremiumTripPlan extends StatelessWidget {
  const PremiumTripPlan({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon and Title
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Assets.icons.icPremium.svg(),
              Gap(6),
              Text(
                "Premium Trip Plan?",
                style: titleMedium?.copyWith(
                  color: AppColors.primaryNormal,
                  fontWeight: FontWeight.w700,
                  fontSize: 20.sp,
                ),
              ),
            ],
          ),
          Gap(20.h),

          // Subtitle
          Padding(
           padding: EdgeInsets.only(left: 8, right: 8),
            child: Text(
              "For more granular control over the AI-generated draft, you can add a destination for each day below.",
              textAlign: TextAlign.start,
              style: titleMedium?.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.w400,
                fontSize: 12.sp,
              ),
            ),
          ),
          Gap(24.h),

          // Toggle Switch UI
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap(8.w),
              // Free Trip Plan
              Text(
                "Free Trip Plan",
                style: titleMedium?.copyWith(
                  color: AppColors.lightBlackText,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                ),
              ),
              Gap(40.w),
              // Toggle Switch
              CustomSwitch(),
              Gap(40.w),

              // Paid Trip Plan
              Expanded(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Gap(30.h),
                    Text(
                      "Paid Trip Plan",
                      style: titleMedium?.copyWith(
                        color: AppColors.lightBlackText,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 4),
                      padding: EdgeInsets.symmetric(horizontal: 38, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColors.primaryNormal,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Text(
                        "\$50",
                        style: titleMediumSaira?.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
