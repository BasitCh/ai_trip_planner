import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_hero/src/application/itinerary/create_itinerary_cubit.dart';
import 'package:travel_hero/src/application/itinerary/create_itinerary_state.dart';
import 'package:travel_hero/src/application/itinerary/request_itinerary/mood_cubit.dart';
import 'package:travel_hero/src/infrastructure/routes/app_routes.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:travel_hero/widgets/mood_list.dart';
import 'package:travel_hero/widgets/create_trip_plan_app_bar.dart';
import 'package:travel_hero/widgets/premium_trip_plan.dart';
import 'package:travel_hero/widgets/trip_plan_heading.dart';
import 'package:widgets_book/widgets_book.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<MoodCubit>(create: (_) =>MoodCubit(context),
      child: BaseScaffold(
        body: BlocBuilder<CreateItineraryCubit, CreateItineraryState?>(
          builder: (context, state) {
            final itineraryCubit = context.read<CreateItineraryCubit>();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(50.h),
                CreateTripPlanAppBar(
                  showProgressBar: true,
                  current: 2,
                  stepText: 'Review your summary',
                  titleText: 'Create a Trip Plan',
                  subTitleText:
                      'Review the summary of your prompt and click generate if it\'s good to go',
                  max: 4,
                ),
                Gap(14.h),
                // Editable Summary
                Padding(
                    padding: EdgeInsets.only(left: 24, right: 24),
                    child: TripPlanHeading(
                      title: 'Review Summary',
                      icon: Assets.icons.icReview.svg(),
                    )),
                Gap(12.h),
                // Prompt Text
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 24),
                  child: ListTile(
                    title: Text(itineraryCubit.promptController.text,
                        style: titleMedium?.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w500,
                            fontSize: 20.sp)),
                    trailing: Assets.icons.icEditSummary.svg(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 24, right: 24),
                  child: Text('Select Mood',
                      style: titleMediumSaira?.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp)),
                ),
                Gap(16.h),
                Padding(
                  padding: EdgeInsets.only(left: 12, right: 12),
                  child: BlocBuilder<MoodCubit, List<Mood>>(
                    builder: (context, moods) {
                      return MoodList(
                        moods: moods,
                        isRequestMood: false,
                      );
                    },
                  ),
                ),
                //Gap(15.h),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Padding(
                        //   padding:
                        //       EdgeInsets.only(left: 12, right: 12, top: 10.h),
                        //   child: ListView.builder(
                        //     padding: EdgeInsets.zero,
                        //     itemCount: state?.dayPlans.length,
                        //     physics: NeverScrollableScrollPhysics(),
                        //     shrinkWrap: true,
                        //     itemBuilder: (context, index) {
                        //       return Column(
                        //         children: [
                        //           Container(
                        //             decoration: BoxDecoration(
                        //                 borderRadius:
                        //                     BorderRadius.all(Radius.circular(10)),
                        //                 color: AppColors.inputEnabled),
                        //             child: Dismissible(
                        //               key: ValueKey(state?.dayPlans[index]),
                        //               direction: DismissDirection.endToStart,
                        //               background: Container(
                        //                 color: Colors.red,
                        //                 alignment: Alignment.centerRight,
                        //                 padding: const EdgeInsets.only(right: 20),
                        //                 child: const Icon(Icons.delete,
                        //                     color: Colors.white),
                        //               ),
                        //               onDismissed: (_) =>
                        //                   itineraryCubit.deleteDay(index),
                        //               child: ListTile(
                        //                 title: Text(
                        //                     state?.dayPlans[index].title ?? '',
                        //                     style: titleMedium?.copyWith(
                        //                         color: AppColors.black,
                        //                         fontWeight: FontWeight.w400,
                        //                         fontSize: 16.sp)),
                        //                 leading: Text(
                        //                   state?.dayPlans[index].day.toString() ??
                        //                       '',
                        //                   style: titleMedium?.copyWith(
                        //                       color: AppColors.black,
                        //                       fontWeight: FontWeight.w700,
                        //                       fontSize: 16.sp),
                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //           Gap(10.h),
                        //         ],
                        //       );
                        //     },
                        //   ),
                        // ),
                        // Padding(
                        //   padding:
                        //       EdgeInsets.only(left: 24, right: 24, top: 16.h),
                        //   child: InkWell(
                        //     onTap: () => itineraryCubit.addDay(DayPlan(
                        //         day: 1,
                        //         title: 'test',
                        //         date: 'test',
                        //         activities: [
                        //           Activity(
                        //               name:
                        //                   "Carlton Hotel, Khan Sao, Jodd's Fair",
                        //               description:
                        //                   "Create a hiking and camping Trip Plan for two in Bangkok, Thailand. The trip should be for 14 days, starting from 15th Oct 2024",
                        //               address:
                        //                   "Carlton Hotel, Khan Sao, Jodd's Fair",
                        //               coordinates: Coordinates(
                        //                   lat: 13.730188, lng: 100.567303),
                        //               images: [],)
                        //         ],),),
                        //     child: Row(
                        //       mainAxisSize: MainAxisSize.min,
                        //       // Keeps the row size compact
                        //       children: [
                        //         Assets.icons.icAddMore.svg(),
                        //         // Adjust the space between icon and text
                        //         Text(
                        //           "Add More",
                        //           style: titleMedium?.copyWith(
                        //             color: AppColors.textPrimary,
                        //             fontWeight: FontWeight.w600,
                        //             fontSize: 14.sp,
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // mood selection

                        // Add More Button
                        PremiumTripPlan(),
                        // Good to Go Button
                      ],
                    ),
                  ),
                ),
                BlocBuilder<MoodCubit, List<Mood>>(builder: (context, moods) {
                  return Padding(
                    padding: EdgeInsets.only(left: 12, right: 12, bottom: 5),
                    child: AppButton.lightRed(
                      onPressed:  context.read<MoodCubit>().isMoodSet()?() {
                        context.pushNamed(
                          NavigationPath.generatingTripPlanRouteUri,
                        );
                      }:null,
                      radius: 30,
                      child: Text(
                        'Good To Go',
                        style: titleMediumSaira?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  );
                }),
                // Day List Section
              ],
            );
          },
        ),
      ),
    );
  }
}
