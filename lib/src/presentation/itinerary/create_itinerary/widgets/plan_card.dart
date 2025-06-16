
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:travel_hero/src/application/itinerary/create_itinerary_cubit.dart';
import 'package:travel_hero/src/application/itinerary/create_itinerary_state.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:widgets_book/widgets_book.dart';

class PlanCard extends StatelessWidget {
  const PlanCard({super.key, required this.price, required this.title, required this.description, required this.benefits, required this.buttonText, required this.color});
  final String price;
  final  String title;
  final String description;
  final List<String> benefits;
  final String buttonText;
  final Color color;
  final bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    bool isDarkBackground = color != Colors.white;
    return  Container(
      width: 300,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Assets.icons.icTakeoff.svg(),
          !isDarkBackground
              ? Text(price,
              style: titleXSmallWhite?.copyWith(
                  fontSize: 36.sp,
                  fontWeight: FontWeight.w500,
                  color: isDarkBackground
                      ? Colors.white
                      : AppColors.textPrimary))
              : RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: price,
                  style: headerStyleInter?.copyWith(
                      fontSize: 36.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.white),
                ),
                TextSpan(
                  text: ' / Trip Plan',
                  style: headerStyleInter?.copyWith(
                      color: AppColors.white,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          isDarkBackground
              ? SizedBox.shrink()
              : Text(title,
              style: titleXSmallWhite?.copyWith(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkPurpleBlue)),
          isDarkBackground
              ? SizedBox.shrink()
              : RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '5 Day Trip Plan to Thailand by',
                  style: headerStyleInter?.copyWith(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary),
                ),
                TextSpan(
                  text: '\nPaddy Doyyle.',
                  style: headerStyleInter?.copyWith(
                      color: AppColors.primary,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          Gap(19.h),
          isDarkBackground
              ? Text(
            description,
            textAlign: TextAlign.start,
            style: titleXSmallWhite?.copyWith(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.white),
          )
              : SizedBox.shrink(),
          isDarkBackground ? Gap(25.h) : Gap(21.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: benefits
                .map(
                  (benefit) => Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      isDarkBackground
                          ? Assets.icons.icBulletPointDark.svg()
                          : Assets.icons.icBulletPointWhite.svg(),
                      Gap(10),
                      Expanded(
                          child: Text(benefit,
                              style: titleXSmallWhite?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp,
                                  color: isDarkBackground
                                      ? AppColors.white
                                      : AppColors.charcoalBlack))),
                    ],
                  ),
                  Gap(11),
                ],
              ),
            )
                .toList(),
          ),
          isDarkBackground ? Gap(33.h) : Gap(11.h),
          SizedBox(
            height: 45.h,
            child: isDarkBackground
                ? AppButton.white(
              onPressed: () {
                //context.read<CreateItineraryCubit>().saveItinerary();
              },
              radius: 30,
              child: Text(
                'Request a Trip Plan',
                textAlign: TextAlign.center,
                style: titleMediumSaira?.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 15.sp,
                  color: AppColors.primaryNormal,
                ),
              ),
            )
                : BlocBuilder<CreateItineraryCubit, CreateItineraryState?>(
              builder: (context, state) {
                return IgnorePointer(
                  ignoring: state!.unlockingItinerary!,
                  child: AppButton.lightRed(
                    onPressed: () {
                      context
                          .read<CreateItineraryCubit>()
                          .unlockItinerary();
                    },
                    radius: 30,
                    child: state.unlockingItinerary!
                        ? AppButtonLoading()
                        : Text(
                      'Get the plan',
                      style: titleMediumSaira?.copyWith(
                        fontWeight: FontWeight.w800,
                        fontSize: 15.sp,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
