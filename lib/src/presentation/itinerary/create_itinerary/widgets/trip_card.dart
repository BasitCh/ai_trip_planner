import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:travel_hero/src/application/create_trip_plan/trip_card_cubit.dart';
import 'package:travel_hero/src/application/main/cubit/drawer_cubit.dart';
import 'package:travel_hero/src/domain/itinerary/activity.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:travel_hero/src/presentation/itinerary/create_itinerary/widgets/edit_itinerary_step1.dart';
import 'package:travel_hero/src/presentation/itinerary/create_itinerary/widgets/trip_card_with_images.dart';
import 'package:widgets_book/widgets_book.dart';

class TripCard extends StatelessWidget {
  const TripCard({
    super.key,
    required this.innerIndex,
    required this.activity,
    required this.dayIndex,
    required this.isPaid,
    this.isViewOnly = false,
  });

  final Activity activity;
  final int innerIndex;
  final int dayIndex;
  final bool isPaid;
  final bool isViewOnly;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => TripCardCubit(),
        child: BlocBuilder<TripCardCubit, Map<int, bool>>(
            builder: (context, expandedState) {
          final isExpanded = isTravelerMode && isPaid
              ? innerIndex == 0 && dayIndex == 0
              : expandedState[innerIndex] ?? true;
          return Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
              // 🔹 Removes default border/divider
              splashColor: Colors.transparent,
              // 🔹 Avoids background highlight effect
              highlightColor:
                  Colors.transparent, // 🔹 Avoids unwanted background effect
            ),
            child: IgnorePointer(
              ignoring: isTravelerMode && isPaid,
              child: ExpansionTile(
                initiallyExpanded: isTravelerMode && isPaid
                    ? innerIndex == 0 && dayIndex == 0
                    : isExpanded,
                //key: ValueKey(isExpanded), // Forces rebuild when state changes
                tilePadding: EdgeInsets.zero,
                backgroundColor: AppColors.transparent,
                maintainState: true,
                collapsedBackgroundColor: AppColors.transparent,
                onExpansionChanged: (expanded) {
                  context.read<TripCardCubit>().toggleExpansion(innerIndex);
                },
                trailing: AnimatedRotation(
                  turns: isExpanded ? 0.5 : 0.0, // Rotate when expanded
                  duration: const Duration(milliseconds: 300),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.black,
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColors.black,
                            radius: 12,
                            child: Text(
                              (innerIndex + 1).toString(),
                              style: titleXSmall?.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                          Gap(5.h),
                          Container(
                            width: 1,
                            height: 20,
                            color: AppColors.grey50,
                          ),
                        ],
                      ),
                      Gap(8.w),
                      Expanded(
                          child: Text(
                        activity.name,
                        style: titleXSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 17.sp,
                          color: AppColors.black,
                        ),
                      )),
                      isTravelerMode && isPaid || isViewOnly
                          ? SizedBox.shrink()
                          : IconButton(
                              onPressed: () => showBottomSheetStep1(
                                  context, dayIndex, innerIndex),
                              icon: Assets.icons.icEditSingle.svg(),
                            ),
                    ],
                  ),
                ),
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Row with number, title, and edit icon

                      // Image Section
                      TripCardWithImages(
                        activity: activity,
                      ),
                      Gap(10.h),
                      Card(
                        elevation: 3,
                        color: AppColors.white,
                        //margin: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text(
                                activity.description,
                                style: titleXSmall?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.sp,
                                  color: AppColors.textColorLightBlack,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Assets.icons.icViewMap.svg(),
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "View on Map",
                                    style: titleXSmall?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11.sp,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ),
                                Gap(23.w),
                              ],
                            ),
                          ],
                        ),
                      )
                      // Description Section
                    ],
                  )
                ],
              ),
            ),
          );
        }));
  }
}
