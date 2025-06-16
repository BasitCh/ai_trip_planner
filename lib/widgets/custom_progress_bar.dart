import 'package:flutter/material.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:widgets_book/widgets_book.dart';

class CustomProgressBar extends StatelessWidget {
  final double max;
  final double current;
  final Color color;
  final String? stepText;

  const CustomProgressBar(
      {super.key,
      required this.max,
      required this.current,
        this.stepText,
      this.color = AppColors.primary});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, boxConstraints) {
        var x = boxConstraints.maxWidth;
        var percent = (current / max) * x;
        return Column(
          children: [
            Stack(
              children: [
                Container(
                  width: x,
                  height: 7,
                  decoration: BoxDecoration(
                    color: AppColors.progressLight,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  width: percent,
                  height: 7,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    margin: EdgeInsets.only(top: 12),
                    //color: AppColors.red,
                    width: max==current?percent-50:percent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          transform: Matrix4.translationValues(current==1?-18:-30, 0, 0),
                          child: Text('Step ${(current ?? 1).toInt().toString()}:',
                              textAlign: TextAlign.start,
                              style: bodySmall?.copyWith(
                                  fontSize: 10.sp,
                                  color: AppColors.textTertiary5,
                                  fontWeight: FontWeight.w500)),
                        ),
                        Text(
                          stepText??'Write a prompt',
                          textAlign: TextAlign.start,
                          style: bodySmall?.copyWith(
                              fontSize: 10.sp,
                              color: AppColors.textTertiary5,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    )

                    // RichText(
                    //   textAlign: TextAlign.end,
                    //   text: TextSpan(
                    //     text: 'Step ${(current ?? 1).toInt().toString()}:',
                    //     style: bodySmall?.copyWith(
                    //         fontSize: 10.sp,
                    //         color: AppColors.textTertiary5,
                    //         fontWeight: FontWeight.w500),
                    //     children: [
                    //       TextSpan(
                    //         text: '\nWrite a prompt',
                    //         style: bodySmall?.copyWith(
                    //             fontSize: 10.sp,
                    //             color: AppColors.textTertiary5,
                    //             fontWeight: FontWeight.w500),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    )
              ],
            ),
          ],
        );
      },
    );
  }
}
