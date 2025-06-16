import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:travel_hero/src/application/itinerary/request_itinerary/date_selection_cubit.dart';
import 'package:travel_hero/src/application/itinerary/request_itinerary/date_selection_state.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:travel_hero/src/presentation/itinerary/request_itinerary/widgets/month_list.dart';
import 'package:widgets_book/widgets_book.dart';

class TripLengthSelection extends StatelessWidget {
  const TripLengthSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DateSelectionCubit, DateSelectionState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(right: 43),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Total Days',
                      style: titleXSmallWhite?.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      InkWell(
                          onTap: () =>
                              context.read<DateSelectionCubit>().decrementCounter(context),
                          child: Assets.icons.icMinusCounter.svg()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          '${state.dayCounter}',
                          style: titleXSmallWhite?.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                      InkWell(
                          onTap: () =>
                              context.read<DateSelectionCubit>().incrementCounter(context),
                          child: Assets.icons.icPlushCounter.svg()),
                    ],
                  ),
                ],
              ),
              Gap(41.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select the month",
                    style: titleMediumSaira?.copyWith(
                        color: AppColors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700),
                  ),
                  Gap(20.h),
                  BlocBuilder<DateSelectionCubit, DateSelectionState>(
                    builder: (context, month) {
                      return MonthsList(dateSelectionCubit: context.read<DateSelectionCubit>(), months: month.selectedMonths);
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
