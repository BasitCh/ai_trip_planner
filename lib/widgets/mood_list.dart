import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_hero/src/application/itinerary/request_itinerary/mood_cubit.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:widgets_book/widgets_book.dart';

class MoodList extends StatelessWidget {
  const MoodList({super.key, required this.moods,this.isRequestMood=true});
  final List<Mood> moods;
  final bool isRequestMood;
  @override
  Widget build(BuildContext context) {
    final moodCubit = context.read<MoodCubit>();
    return SizedBox(
      height: 57.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: moods.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => moodCubit.selectMood(index, context,isRequestMood: isRequestMood),
            child: Container(
              width: 147.w,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: moods[index].isSelected
                        ? AppColors.primary
                        : AppColors.transparent,
                    width: 1,
                  ),
                  color: AppColors.fillColor),
              child: Align(
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
            ),
          );
        },
      ),
    );
  }
}
