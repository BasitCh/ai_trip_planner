import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:travel_hero/src/application/itinerary/create_itinerary_cubit.dart';
import 'package:travel_hero/src/domain/itinerary/travel_itinerary.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:widgets_book/widgets_book.dart';

class TripPlanCardHeader extends StatelessWidget {
  const TripPlanCardHeader({super.key, this.travelItinerary});
  final TravelItinerary? travelItinerary;
  @override
  Widget build(BuildContext context) {
    final createItineraryCubit = context.read<CreateItineraryCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title Row with Lock Icon
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 7,
              child: Text(
                travelItinerary?.destination ?? '',
                maxLines: 2,
                style: titleMediumSaira?.copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 25.sp),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primaryNormal,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Row(
                  children: [
                  createItineraryCubit.isPaidWidget(
                                  itinerary: travelItinerary) ?  Assets.icons.icLock.svg() : Assets.icons.icUnlock.svg(),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                          createItineraryCubit.isPaidWidget(
                                  itinerary: travelItinerary)
                              ? 'Locked'
                              : 'Unlocked',
                          style: titleXSmall?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                            color: AppColors.white,
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Gap(12.h),

        // Description
        Text(
          "Here is an AI-generated draft of your trip plan. You can edit it before publishing.",
          style: titleXSmall?.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 16.sp,
            color: AppColors.black,
          ),
        ),
        Gap(24.h),

        // Details Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // City Section
            Expanded(
              child: Row(
                children: [
                  Assets.icons.icCity.svg(fit: BoxFit.contain),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "City",
                          style: titleXSmall?.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 10.sp,
                            color: AppColors.textColorGrey,
                          ),
                        ),
                        Text(
                          travelItinerary?.destination ?? '',
                          maxLines: 2,
                          style: titleXSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Gap(30.w),
            // Vertical Divider
            Container(
              width: 2,
              height: 68.h,
              color: AppColors.progressLight,
            ),
            Gap(25.w),

            // Location Section
            Expanded(
              child: Row(
                children: [
                  Assets.icons.icLocation.svg(
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Location",
                          style: titleXSmall?.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 10.sp,
                            color: AppColors.textColorGrey,
                          ),
                        ),
                        Text(
                          travelItinerary?.destination ?? '',
                          maxLines: 2,
                          style: titleXSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
