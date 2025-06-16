import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_hero/src/application/itinerary/create_itinerary_cubit.dart';
import 'package:travel_hero/src/infrastructure/routes/app_routes.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:travel_hero/src/presentation/itinerary/create_itinerary/widgets/prompt_card.dart';
import 'package:travel_hero/widgets/create_trip_plan_app_bar.dart';
import 'package:travel_hero/widgets/trip_plan_heading.dart';
import 'package:widgets_book/widgets_book.dart';

class PromptPage extends StatelessWidget {
  const PromptPage({super.key});
  @override
  Widget build(BuildContext context) {
    final createItinerayCubit = context.read<CreateItineraryCubit>();
    return BaseScaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          Gap(50.h),
          CreateTripPlanAppBar(
            showProgressBar: true,
            current: 1,
            titleText: 'Create a Trip Plan',
            subTitleText:
                'Generating the Trip Plan through the magical\nAI, Please wait',
            max: 4,
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Gap(16.h),
                Padding(
                    padding: EdgeInsets.only(left: 24, right: 24),
                    child: TripPlanHeading()),
                Gap(16.h),
                Padding(
                  padding: EdgeInsets.only(left: 12, right: 12),
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    children: [
                      PromptCard(
                        title:
                            'Plan a romantic getaway in Thailand for two people. The trip should last for 7 days, starting from 15th August 2024',
                        color: AppColors.primaryNormal.withAlpha((0.40 * 255).toInt()),
                      ),
                      PromptCard(
                        title:
                            'Create an adventure travel Trip Plan for two friends in Costa Rica. It should be for 10 days, starting from 5th November 2024',
                        color: AppColors.purple,
                      ),
                      PromptCard(
                        title:
                            'Plan a romantic getaway in Thailand for two people. The trip should last for 5 days, starting from 15th August 2024',
                        color: AppColors.skyBlueLight,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: AppTextField(
                    controller: createItinerayCubit.promptController,
                    maxLines: 3,
                    borderRadius: 20,
                    textInputAction: TextInputAction.done,
                    validator: (text) {
                      return createItinerayCubit.validateValue(text,
                          message: 'Please enter prompt');
                    },
                    contentPadding: EdgeInsets.only(
                        left: 27, right: 80, top: 20, bottom: 20),
                    hintText:
                        'Create a hiking and camping Trip Plan for two in the Bangkok, Thailand. The trip should be for 2 days, starting from 3rd August 2024',
                    bordersidecolor: BorderSide(
                        color: AppColors.borderColorTextFiled.withAlpha((.35 * 255).toInt())),
                    labelText: 'Write your prompt',
                    hintStyle: subTitleStyle?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColors.hintTextFiled.withAlpha((.64 * 255).toInt())),
                  ),
                ),
                Gap(20.h),
                Padding(
                  padding: EdgeInsets.only(left: 12, right: 12, bottom: 5),
                  child: AppButton.lightRed(
                    onPressed: () async {
                      context.pushNamed(NavigationPath.reviewTripRouteUri);
                    },
                    radius: 30,
                    child: Text(
                      'Generate & Review',
                      style: titleMediumSaira?.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
        ],
      ),
    );
  }
}
