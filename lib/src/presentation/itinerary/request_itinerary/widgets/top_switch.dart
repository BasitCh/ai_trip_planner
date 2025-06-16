import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_hero/src/application/itinerary/request_itinerary/date_selection_cubit.dart';
import 'package:travel_hero/src/application/itinerary/request_itinerary/date_selection_state.dart';
import 'package:travel_hero/src/application/itinerary/request_itinerary/itinerary_request_cubit.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:widgets_book/widgets_book.dart';

class TopSwitch extends StatelessWidget {
  const TopSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DateSelectionCubit, DateSelectionState>(
      buildWhen: (previous, current) => previous != current,
      // Only rebuild on state change
      builder: (context, state) {
        return Center(
          child: Container(
            width: context.width,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.textColorGrey.withValues(alpha: 0.29),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Stack(
                children: [
                  // Animated background switch
                  AnimatedAlign(
                    duration: Duration(milliseconds: 100),
                    curve: Curves.easeInOut,
                    alignment:
                        state.dateSelectionMethod == DateSelectionMethod.range
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                    child: Container(
                      width: 160,
                      // Half the width of the parent container
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  // Row with options
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            toggleDateSelectionMethod(context, state);
                          },
                          child: Center(
                            child: Text("Dates (MM/DD)",
                                style: titleXSmallWhite?.copyWith(
                                  color: state.dateSelectionMethod ==
                                          DateSelectionMethod.range
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11.sp,
                                )),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            toggleDateSelectionMethod(context, state);
                          },
                          child: Center(
                            child: Text("Trip Length",
                                style: titleXSmallWhite?.copyWith(
                                  color: state.dateSelectionMethod ==
                                          DateSelectionMethod.range
                                      ? AppColors.black
                                      : AppColors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11.sp,
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void toggleDateSelectionMethod(
      BuildContext context, DateSelectionState state) {
    if (state.dateSelectionMethod == DateSelectionMethod.range) {
      context
          .read<DateSelectionCubit>()
          .toggleSelectionMode(context, DateSelectionMethod.length);
    } else {
      context
          .read<DateSelectionCubit>()
          .toggleSelectionMode(context, DateSelectionMethod.range);
    }
  }
}
