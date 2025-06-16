import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_hero/src/application/itinerary/create_itinerary_cubit.dart';
import 'package:travel_hero/src/application/itinerary/request_itinerary/date_selection_cubit.dart';
import 'package:travel_hero/src/application/itinerary/request_itinerary/itinerary_request_cubit.dart';
import 'package:travel_hero/src/application/itinerary/request_itinerary/mood_cubit.dart';
import 'package:travel_hero/src/application/login_register/app_user_cubit.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:travel_hero/src/presentation/itinerary/request_itinerary/widgets/bottom_button.dart';
import 'package:travel_hero/src/presentation/itinerary/request_itinerary/widgets/date_selection_calender_read_only.dart';
import 'package:travel_hero/src/presentation/itinerary/request_itinerary/widgets/month_list_selected.dart';
import 'package:travel_hero/src/presentation/itinerary/request_itinerary/widgets/mood_list_selected.dart';
import 'package:travel_hero/src/presentation/itinerary/request_itinerary/widgets/profile_card.dart';
import 'package:travel_hero/widgets/custom_app_bar.dart';
import 'package:travel_hero/widgets/custom_image_view.dart';
import 'package:travel_hero/widgets/text_field_with_label.dart';
import 'package:widgets_book/widgets_book.dart';

class TripPreviewScreen extends StatelessWidget {
  const TripPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: CustomAppBar(
        title: Text(
          'Preview',
          style: titleXSmallWhite?.copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: BlocBuilder<ItineraryRequestCubit, ItineraryRequestState>(
              builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CustomImageView(
                      height: 361.h,
                      width: context.width,
                      fit: BoxFit.cover,
                      imagePath: state.itineraryRequest.placeImage ?? '',
                    )),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.itineraryRequest.placeName ?? '',
                            style: titleXSmallWhite?.copyWith(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.black,
                            ),
                          ),
                          Text(
                            state.itineraryRequest.placeDescription ?? '',
                            style: titleXSmallWhite?.copyWith(
                              fontSize: 8.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomImageView(
                      radius: BorderRadius.circular(50),
                      height: 48,
                      width: 48,
                      imagePath:
                          context.read<AppUserCubit>().state?.pictureUrl ?? '',
                    ),
                  ],
                ),
                Gap(14.h),
                Divider(
                  color: AppColors.borderColorTextFiled.withValues(alpha: 0.25),
                ),
                Gap(24.h),
                Text(
                  'Month & Dates',
                  style: titleXSmallWhite?.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color:
                        AppColors.borderColorTextFiled.withValues(alpha: 0.85),
                  ),
                ),
                Gap(10.h),
                TextFieldWithLabel(
                  readOnly: true,
                  margin: EdgeInsets.all(0),
                  controller:
                      context.read<ItineraryRequestCubit>().noOfGuestController,
                  labelTitle: 'Number of guests',
                  hintText: 'xyz',
                ),
                SizedBox(height: 8),
                TextFieldWithLabel(
                  readOnly: true,
                  margin: EdgeInsets.all(0),
                  controller:
                      context.read<ItineraryRequestCubit>().nameController,
                  labelTitle: 'Name',
                  hintText: 'xyz',
                ),
                SizedBox(height: 8),
                Text(
                  'Trip length',
                  style: titleXSmallWhite?.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color:
                        AppColors.borderColorTextFiled.withValues(alpha: 0.85),
                  ),
                ),
                if (state.dateSelectionMethod ==
                    DateSelectionMethod.length) ...[
                  Column(
                    children: [
                      Gap(32.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Total Days',
                            style: titleXSmallWhite?.copyWith(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.black,
                            ),
                          ),
                          Spacer(),
                          Row(
                            children: [
                              Assets.icons.icMinusCounter.svg(),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  '${state.itineraryRequest.duration ?? 1}',
                                  style: titleXSmallWhite?.copyWith(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.black,
                                  ),
                                ),
                              ),
                              Assets.icons.icPlushCounter.svg(),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )
                ],
                if (state.dateSelectionMethod ==
                    DateSelectionMethod.length) ...[
                  Column(
                    children: [
                      Gap(40.h),
                      MonthsListSelected(
                          months: context
                              .watch<DateSelectionCubit>()
                              .state
                              .selectedMonths),
                    ],
                  )
                ],
                if (state.dateSelectionMethod == DateSelectionMethod.range) ...[
                  DateSelectionCalenderReadOnly(
                    tripPlanState: state,
                  )
                ],
                Gap(32.h),
                Text(
                  "Mood",
                  style: titleMediumSaira?.copyWith(
                      color: AppColors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700),
                ),
                Gap(20.h),
                MoodListSelected(moods: context.watch<MoodCubit>().state),
                Gap(40.h),
                Divider(
                  color: AppColors.borderColorTextFiled.withValues(alpha: 0.25),
                ),
                Gap(40.h),
                ProfileCard(),
                Gap(50.h),
                IgnorePointer(
                  ignoring: state.submittingRequest!,
                  child: BottomButton(
                    nextButtonText: 'Submit',
                    isLoading: state.submittingRequest,
                    onPressedNext: () {
                      final itinerary = context
                          .read<CreateItineraryCubit>()
                          .state
                          ?.travelItinerary;
                      context.read<ItineraryRequestCubit>().submitRequest(
                          travelHeroId: itinerary?.userId,
                          travelHeroName: itinerary?.createdBy,
                          travelHeroProfileUrl: itinerary?.profileUrl ?? '');
                    },
                    onPressedBack: () => context.pop(),
                  ),
                )
              ],
            );
          })),
    );
  }
}
