import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:travel_hero/src/presentation/auth/intro/widgets/skip_button.dart';
import 'package:widgets_book/widgets_book.dart';

class OnboardingFooter extends StatefulWidget {
  const OnboardingFooter({required this.currentIndex, this.onNext, this.onFinish, super.key});

  final int currentIndex;
  final VoidCallback? onNext;
  final VoidCallback? onFinish;

  @override
  State<OnboardingFooter> createState() => _OnboardingFooterState();
}

class _OnboardingFooterState extends State<OnboardingFooter> {

  double get screenSize => context.width;
  double smallScreen = 380;

  List<Widget> onboardingSubtitles() => [
    SizedBox(
      height: 55.h,

      child: AutoSizeText.rich(
        TextSpan(
          text: localizations.an_ultimate_space,
          style: titleSmall?.copyWith(color: AppColors.textSecondary),
          children: <TextSpan>[
            TextSpan(
                text: localizations.breed,
                style: titleSmall?.copyWith(fontFamily: FontFamily.saira, fontStyle: FontStyle.italic, color: AppColors.textSecondary)),
            TextSpan(text: localizations.comma_space),
            TextSpan(
                text: localizations.record,
                style: titleSmall?.copyWith(fontStyle: FontStyle.italic, fontFamily: FontFamily.saira, color: AppColors.textSecondary)),
            TextSpan(text: localizations.comma_space),
            TextSpan(
                text: localizations.rehome,
                style: titleSmall?.copyWith(fontStyle: FontStyle.italic, fontFamily: FontFamily.saira, color: AppColors.textSecondary)),
            TextSpan(text: localizations.in_one_place),
          ],
        ),
        minFontSize: 12,
        maxFontSize: 18,
        style: titleSmall?.copyWith(color: AppColors.textSecondary),
        textAlign: TextAlign.center,
      ),
    ),
    SizedBox(
        height: 55.h,
        child: AutoSizeText(
            minFontSize: 14,
            maxFontSize: screenSize>smallScreen?18:16,
            localizations.onboarding_subtitle_2,
            style: titleSmall?.copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center)),
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.h),
      child: SizedBox(
        height: 55.h,
        child: AutoSizeText(
            localizations.onboarding_subtitle_3,
            maxLines: 2,
            minFontSize: 15,
            maxFontSize: 18,
            style: titleSmall?.copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(

      mainAxisSize: MainAxisSize.min,
      children: [
        // Container(
        //   padding: EdgeInsets.symmetric(horizontal: 16.h),
        //   child: Column(
        //     mainAxisSize: MainAxisSize.min,
        //     children: [
        //       Container(
        //         padding: EdgeInsets.symmetric(horizontal: 34.h),
        //         child: Column(
        //           mainAxisSize: MainAxisSize.min,
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           children: [
        //             SizedBox(
        //               height: 64.h,
        //               child: AutoSizeText(
        //                   widget.currentIndex == 0? localizations.onboarding_title_1 : widget.currentIndex == 1? localizations.onboarding_title_2 : localizations.onboarding_title_3,
        //                   style: titleMedium,
        //                   maxLines: 2,
        //                   minFontSize: 20,
        //                   maxFontSize: 24,
        //                   textAlign: TextAlign.center),
        //             ),
        //             Gap(36.h),
        //             // Align(alignment: Alignment.center,child: widget.currentIndex == 0? onboardingSubtitles()[0] : widget.currentIndex == 1? onboardingSubtitles()[1] : onboardingSubtitles()[2])
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // Gap(95.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(2, (index) {
            return Container(
              margin: const EdgeInsets.all(4),
              width: widget.currentIndex == index ? 24 : 7,
              height: widget.currentIndex == index ? 8 : 7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(99)),
                shape: BoxShape.rectangle,
                color: widget.currentIndex == index ? AppColors.white : AppColors.white.withOpacity(.7),
              ),
            );
          }),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 22.h),
          child: widget.currentIndex < 1
              ? AppButton.white(
                  onPressed: widget.onNext,
            radius: 99,
                  child: Text(localizations.next, style: TextStyle(
                    fontFamily: FontFamily.saira,
                    fontSize: 21,
                    color: Color(0xFF333333),
                  ),

                  ),
                )
              : AppButton.white(
                  onPressed: widget.onFinish,
                  radius: 99,
                  child: Text(localizations.get_started, style: TextStyle(
                    fontFamily: FontFamily.saira,
                    fontSize: 21,
                    color: Color(0xFF333333),
                  ),),
                ),
        ),
        widget.currentIndex==0?SkipButton():SizedBox.shrink(),
        Gap(15)
      ],
    );
  }
}
