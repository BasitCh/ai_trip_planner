import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_hero/src/application/intro/wizard_cubit.dart';
import 'package:travel_hero/src/infrastructure/routes/app_routes.dart';
import 'package:widgets_book/widgets_book.dart';

class WizardPage extends StatelessWidget {
  const WizardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WizardCubit()..triggerAnimation(),
      child: WizardPageScreen(),
    );
  }
}

class WizardPageScreen extends StatelessWidget {
  const WizardPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        backgroundColor: AppColors.primary,
        body: Stack(
          children: [
            BlocBuilder<WizardCubit, bool>(builder: (context, isAnimated) {
              return AnimatedPositioned(
                duration: const Duration(seconds: 60),
                curve: Curves.easeOut,
                top: isAnimated ? -620.h : 0,
                left: -90.w,
                right: -90.w, // Ensures the child spans the full width
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Assets.images.wizardOne.image(fit: BoxFit.cover),
                ),
              );
            }),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 430.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      AppColors.primary,
                      AppColors.primary,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.0, 0.35, 0.9],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Spacer(),
                    const Text(
                      "Step in and start",
                      style: TextStyle(
                        fontSize: 36,
                        fontFamily: FontFamily.saira,
                        fontWeight: FontWeight.w300,
                        color: AppColors.white,
                      ),
                    ),
                    const Text(
                      "your journey",
                      style: TextStyle(
                        fontSize: 36,
                        fontFamily: FontFamily.saira,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 60.0),
                      child: Assets.icons.icJourney
                          .svg(fit: BoxFit.scaleDown, width: 170),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        "Every journey begins and ends with a great trip plan",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: FontFamily.inter,
                          fontWeight: FontWeight.w500,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 14, right: 14),
                      child: AppButton.white(
                        radius: 32,
                        onPressed: () {
                          context.goNamed(NavigationPath.onboardingRouteUri);
                        },
                        child: const Text(
                          'Next',
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontFamily: FontFamily.saira,
                            fontSize: 21,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.goNamed(NavigationPath.loginRouteUri);
                      },
                      child: const Text(
                        "Skip",
                        style: TextStyle(
                          color: AppColors.white,
                          fontFamily: FontFamily.inter,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
