import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_hero/src/application/itinerary/create_itinerary_cubit.dart';
import 'package:travel_hero/src/application/main/cubit/drawer_cubit.dart';
import 'package:travel_hero/src/domain/itinerary/travel_itinerary.dart';
import 'package:travel_hero/src/infrastructure/routes/app_routes.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:widgets_book/widgets_book.dart';

class UnlockedOverlay extends StatelessWidget {
  const UnlockedOverlay({super.key, this.travelItinerary});
  final TravelItinerary? travelItinerary;

  @override
  Widget build(BuildContext context) {
    final createItineraryCubit = context.read<CreateItineraryCubit>();
    return (!isTravelerMode ||
            travelItinerary?.userId == FirebaseAuth.instance.currentUser?.uid)
        ? const SizedBox.shrink()
        : createItineraryCubit.isPaidWidget(itinerary: travelItinerary)
            ? Container(
                margin: EdgeInsets.only(top: 110),
                child: Card(
                    color: AppColors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(58.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Assets.icons.icUnlocked.svg(),
                          Gap(10.h),
                          Text(
                            'Unlock',
                            style: titleMediumSaira?.copyWith(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.black,
                            ),
                          ),
                          Gap(10.h),
                          Text(
                            'This item is premium and only available to paid users. Upgrade your plan to access this content.',
                            style: titleXSmallWhite?.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black,
                            ),
                          ),
                          SizedBox(height: 20),
                          Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Assets.icons.icUnlocked.svg(),
                                  Gap(10.h),
                                  Expanded(
                                      child: Text('Ability to View all content',
                                          style: titleXSmallWhite?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14.sp,
                                              color: AppColors.charcoalBlack))),
                                ],
                              ),
                              Gap(10.h),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Assets.icons.icChatRed.svg(),
                                  Gap(10),
                                  Expanded(
                                      child: Text('Ability to chat with guide',
                                          style: titleXSmallWhite?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14.sp,
                                              color: AppColors.charcoalBlack))),
                                ],
                              ),
                              Gap(11),
                            ],
                          ),
                          SizedBox(
                            width: 130,
                            height: 40,
                            child: AppButton.lightRed(
                                onPressed: () {
                                  context.pushNamed(
                                      NavigationPath.upgradePlanRouteUri);
                                },
                                radius: 30,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Unlock Now',
                                      textAlign: TextAlign.center,
                                      style: titleMediumSaira?.copyWith(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 15.sp,
                                        color: AppColors.white,
                                      ),
                                    ),
                                    Assets.icons.icArrowRight.svg()
                                  ],
                                )),
                          ),
                        ],
                      ),
                    )),
              )
            : SizedBox.shrink();
  }
}
