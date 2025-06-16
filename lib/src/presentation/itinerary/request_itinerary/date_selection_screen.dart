import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_hero/src/application/itinerary/request_itinerary/date_selection_cubit.dart';
import 'package:travel_hero/src/application/itinerary/request_itinerary/date_selection_state.dart';
import 'package:travel_hero/src/infrastructure/routes/app_routes.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:travel_hero/src/presentation/itinerary/request_itinerary/widgets/bottom_button.dart';
import 'package:travel_hero/src/presentation/itinerary/request_itinerary/widgets/top_switch.dart';
import 'package:travel_hero/src/presentation/itinerary/request_itinerary/widgets/switch_selection.dart';
import 'package:travel_hero/src/presentation/itinerary/request_itinerary/widgets/top_text.dart';
import 'package:travel_hero/widgets/custom_app_bar.dart';
import 'package:widgets_book/widgets_book.dart';

class DateSelectionScreen extends StatelessWidget {
  const DateSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: CustomAppBar(
        title: Text(
          'Select Dates',
          style: titleXSmallWhite?.copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(49.h),
              TopText(
                title: 'When is the trip?',
                subTitle:
                    'Choose a specific date range, or just an approximate\n trip length.',
              ),
              Gap(20.h),
              TopSwitch(),
              Gap(50.h),
              SwitchSelection(),
              Gap(50.h),
              BlocBuilder<DateSelectionCubit, DateSelectionState>(
                  builder: (context, state) {
                return BottomButton(
                  nextButtonText: 'Review Information',
                  onPressedBack: () => context.pop(),
                  onPressedNext: context.read<DateSelectionCubit>().allSet()
                      ? () => context.pushNamed(
                          NavigationPath.tripPlanReviewScreenRouteUri)
                      : null,
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
