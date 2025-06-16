
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:travel_hero/src/application/itinerary/request_itinerary/date_selection_cubit.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:widgets_book/widgets_book.dart';

class MonthsList extends StatelessWidget {
  const MonthsList({super.key, required this.months, required this.dateSelectionCubit});
  final List<MonthModel> months;
  final DateSelectionCubit dateSelectionCubit;
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: months.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () =>
                dateSelectionCubit.toggleMonthSelection(months[index].name,context, ),
            child: Container(
              width: 147.w,
              margin:
              const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: months[index].isSelected
                        ? AppColors.primary
                        : AppColors.transparent,
                    width: 1,
                  ),
                  color: AppColors.fillColor),
              child: Stack(
                children: [
                  months[index].isSelected
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
                    child: Column(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        Assets.icons.icCalender.svg(),
                        Gap(5.h),
                        Text(
                          months[index].name,
                          textAlign: TextAlign.center,
                          style: titleMediumSaira?.copyWith(
                              color: AppColors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
