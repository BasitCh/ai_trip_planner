import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_hero/src/application/itinerary/request_itinerary/mood_cubit.dart';
import 'package:travel_hero/src/infrastructure/routes/app_routes.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:travel_hero/src/presentation/itinerary/request_itinerary/widgets/bottom_button.dart';
import 'package:travel_hero/widgets/mood_list.dart';
import 'package:travel_hero/src/presentation/itinerary/request_itinerary/widgets/top_text.dart';
import 'package:travel_hero/widgets/custom_app_bar.dart';
import 'package:travel_hero/widgets/text_field_with_label.dart';
import 'package:widgets_book/widgets_book.dart';

class DemographicScreen extends StatelessWidget {
  const DemographicScreen({super.key,});
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: CustomAppBar(
        title: Text(
          'Demographic Information',
          style: titleXSmallWhite?.copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gap(49.h),
            TopText(
              title: 'Demographic Information',
              subTitle:
                  'Fill out the basic information for travel hero to create a trip plan',
            ),
            Gap(20.h),
            TextFieldWithLabel(
              textInputType: TextInputType.name,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z\s]*$')),
              ],
              onChanged: (value){
                context.read<MoodCubit>().setName(context);
              },
              controller: context.read<MoodCubit>().nameController,
            ),
            Gap(10.h),
            TextFieldWithLabel(
              controller: context.read<MoodCubit>().guestsController,
              labelTitle: 'Number of guests',
              hintText: 'xyz',
              textInputType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly, // Allows only integer numbers
              ],
              onChanged: (value){
                context.read<MoodCubit>().setGuests(context);
              },
            ),
            Gap(20.h),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Mood",
                    style: titleMediumSaira?.copyWith(
                        color: AppColors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700),
                  ),
                  Gap(10.h),
                  BlocBuilder<MoodCubit, List<Mood>>(
                    builder: (context, moods) {
                      return MoodList(moods: moods,);
                    },
                  ),
                ],
              ),
            ),
            Gap(16.0.h),
    BlocBuilder<MoodCubit, List<Mood>>(
    builder: (context, moods) {
      return BottomButton(
        onPressedBack: () => context.pop(),
        onPressedNext: context.read<MoodCubit>().isAllSet()?() =>
            context.pushNamed(NavigationPath.dateSelectionScreenRouteUri):null,
      );
    }),

            Gap(50.0.h),
          ],
        ),
      ),
    );
  }
}
