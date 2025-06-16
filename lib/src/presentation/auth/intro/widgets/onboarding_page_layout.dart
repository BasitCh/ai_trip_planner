import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_hero/src/application/intro/onboarding_cubit.dart';
import 'package:widgets_book/widgets_book.dart';

class OnboardingPageLayout extends StatelessWidget {
  const OnboardingPageLayout(
      {required this.imageHeight, required this.imagePath, required this.title, required this.subtitle, super.key});

  final double imageHeight;
  final String imagePath;
  final String title;
  final Widget subtitle;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, int>(
      builder: (context, currentIndex) {
        return Padding(
          padding: EdgeInsets.only(left: 5,right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
                child: SvgPicture.asset(
                  imagePath,
                  package: 'widgets_book',
                  fit: BoxFit.contain,
                ),
              ),
        AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: subtitle)
              // Gap(32.h),
            ],
          ),
        );
      },
    );
  }
}
