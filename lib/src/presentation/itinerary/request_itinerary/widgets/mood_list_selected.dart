
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:travel_hero/src/application/itinerary/request_itinerary/mood_cubit.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:widgets_book/widgets_book.dart';

class MoodListSelected extends StatelessWidget {
  const MoodListSelected({super.key, required this.moods,});
  final List<Mood> moods;
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: moods.length,
        itemBuilder: (context, index) {
          return Container(
            width: 147.w,
            margin:
            const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: moods[index].isSelected
                      ? AppColors.primary
                      : AppColors.transparent,
                  width: 1,
                ),
                color: AppColors.fillColor),
            child: Stack(
              children: [
                moods[index].isSelected
                    ? Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, right: 8.0),
                      child: Assets.icons.icTick.svg(),
                    ))
                    : SizedBox.shrink(),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    moods[index].name,
                    textAlign: TextAlign.center,
                    style: titleMediumSaira?.copyWith(
                        color: AppColors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
