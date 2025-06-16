import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_hero/src/infrastructure/routes/app_routes.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:travel_hero/widgets/shader_mask.dart';
import 'package:widgets_book/widgets_book.dart';

class NoTripPlan extends StatelessWidget {
  const NoTripPlan({this.color, super.key});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppShaderMask(
          text: 'No Trip Plans',
          fontSize: 24,
        ),
        Gap(15),
        Text(
            'You haven’t created any trip plans yet. \nStart by creating one now.',
            textAlign: TextAlign.center,
            style: subTitleStyle?.copyWith(
                fontWeight: FontWeight.w400,
                color: AppColors.black.withOpacity(.60),
                fontSize: 16)),
        Gap(28),
        SizedBox(
          height: 47,
          child: Padding(
            padding: const EdgeInsets.only(left: 33.0, right: 33),
            child: AppButton.lightRed(
              onPressed: () {
                context.pushNamed(NavigationPath.promptPageRouteUri);
              },
              radius: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Create a Trip Plan',
                      textAlign: TextAlign.center,
                      style: titleMediumSaira?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.white,
                          fontSize: 20)),
                  Gap(3),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Assets.icons.icArrowRight.svg(),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
