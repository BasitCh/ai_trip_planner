import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_hero/src/application/intro/onboarding_cubit.dart';
import 'package:travel_hero/src/infrastructure/routes/app_routes.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:travel_hero/src/presentation/auth/intro/widgets/onboarding_footer.dart';
import 'package:travel_hero/src/presentation/auth/intro/widgets/onboarding_page_layout.dart';
import 'package:widgets_book/widgets_book.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final double imageHeight = MediaQuery.of(context).size.height / 2;

    return BlocBuilder<OnboardingCubit, int>(
      builder: (context, currentIndex) {
        return Scaffold(
          backgroundColor: AppColors.primary,
          floatingActionButton: OnboardingFooter(
            currentIndex: currentIndex,
            onNext: _onNext,
            onFinish: _onFinish,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          body: PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: _buildPages(context, imageHeight),
          ),
        );
      },
    );
  }

  List<Widget> _buildPages(BuildContext context, double imageHeight) {
    return [
      OnboardingPageLayout(
        imageHeight: imageHeight,
        imagePath: Assets.icons.onboarding1.path,
        title: localizations.onboarding_title_1,
        subtitle: AutoSizeText.rich(
          TextSpan(
            text: localizations.content_creator,
            style: titleSmall?.copyWith(
              color: AppColors.white,
              fontSize: 26,
              fontWeight: FontWeight.w300,
              fontFamily: FontFamily.inter,
            ),
            children: [
              TextSpan(text: ':\n'),
              TextSpan(
                text: localizations.share_local_knowledge,
                style: titleSmall?.copyWith(
                  color: AppColors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  fontFamily: FontFamily.inter,
                ),
              ),
              TextSpan(text: '\n'),
              TextSpan(
                text: localizations.help_travellers,
                style: titleSmall?.copyWith(
                  color: AppColors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  fontFamily: FontFamily.inter,
                ),
              ),
              TextSpan(text: '\n'),
              TextSpan(
                text: localizations.get_paid,
                style: titleSmall?.copyWith(
                  color: AppColors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  fontFamily: FontFamily.inter,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ),
      OnboardingPageLayout(
        imageHeight: imageHeight,
        imagePath: Assets.icons.onboarding2.path,
        title: localizations.onboarding_title_2,
        subtitle: AutoSizeText.rich(
          TextSpan(
            text: localizations.travellers,
            style: titleSmall?.copyWith(
              color: AppColors.white,
              fontSize: 26,
              fontWeight: FontWeight.w300,
              fontFamily: FontFamily.inter,
            ),
            children: [
              TextSpan(text: ':\n'),
              TextSpan(
                text: localizations.find_ready_trip_plans,
                style: titleSmall?.copyWith(
                  color: AppColors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  fontFamily: FontFamily.inter,
                ),
              ),
              TextSpan(text: '\n'),
              TextSpan(
                text: localizations.order_bespoke_plans,
                style: titleSmall?.copyWith(
                  color: AppColors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  fontFamily: FontFamily.inter,
                ),
              ),
              TextSpan(text: '\n'),
              TextSpan(
                text: localizations.made_by_human_guides,
                style: titleSmall?.copyWith(
                  color: AppColors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  fontFamily: FontFamily.inter,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ];
  }

  void _onPageChanged(int index) =>
      BlocProvider.of<OnboardingCubit>(context).goToPage(index, _pageController);

  void _onNext() =>
      BlocProvider.of<OnboardingCubit>(context).nextPage(_pageController);

  void _onFinish() => context.goNamed(NavigationPath.loginRouteUri);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
