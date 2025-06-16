import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:travel_hero/widgets/custom_progress_bar.dart';
import 'package:travel_hero/widgets/shader_mask.dart';
import 'package:widgets_book/widgets_book.dart';

class CreateTripPlanAppBar extends StatelessWidget {
  const CreateTripPlanAppBar(
      {this.titleText,
      this.subTitleText,
      this.showProgressBar = false,
      this.progressBar,
      this.max,
      this.current,
      this.stepText,
      super.key});

  final String? titleText;
  final String? subTitleText;
  final bool showProgressBar;
  final Widget? progressBar;
  final double? max;
  final double? current;
  final String? stepText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () {
                Navigator.pop(context); // Navigate back
              },
            ),
            Gap(35.w),
            Expanded(
              child: Column(
                children: [
                  AppShaderMask(
                    fontSize: 26.sp,
                    text: titleText ?? 'Review Request',
                  ),
                  Text(
                    subTitleText ??
                        'View details of requested Trip Plan by Jane Austin',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: titleXSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.textTertiary5,
                        fontSize: 10.sp),
                  ),
                ],
              ),
            ),
            Gap(70.w),
          ],
        ),
        Visibility(
          visible: showProgressBar,
          child: Column(
            children: [
              Gap(24.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Progress Bar
                  CustomProgressBar(
                    current: current ?? 1,
                    max: max ?? 4,
                    stepText: stepText,
                  ),
                  SizedBox(height: 10),
                  // LayoutBuilder(
                  // builder: (context, constraints) {
                  //   return Padding(
                  //     padding: EdgeInsets.only(left: (current??1 / (max??4).toInt()) * (constraints.maxWidth/8)),
                  //     child: RichText(
                  //       textAlign: TextAlign.center,
                  //       text: TextSpan(
                  //         text: 'Step ${(current??1).toInt().toString()}:',
                  //         style:  bodySmall?.copyWith(
                  //             fontSize: 10.sp,
                  //             color: AppColors.textTertiary5,
                  //             fontWeight: FontWeight.w500
                  //         ),
                  //         children: [
                  //           TextSpan(
                  //             text: '\nWrite a prompt',
                  //             style: bodySmall?.copyWith(
                  //                 fontSize: 10.sp,
                  //                 color: AppColors.textTertiary5,
                  //                 fontWeight: FontWeight.w500
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   );
                  // })        // Step Text
                ],
              ),
              //progressBar??Assets.icons.icProgressBarStep1.svg(fit: BoxFit.fill),
            ],
          ),
        ),
      ],
    );
  }
}
