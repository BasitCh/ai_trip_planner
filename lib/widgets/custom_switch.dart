import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_hero/src/application/create_trip_plan/custom_switch_cubit.dart';
import 'package:travel_hero/src/application/itinerary/create_itinerary_cubit.dart';
import 'package:widgets_book/widgets_book.dart';

class CustomSwitch extends StatefulWidget {
  final VoidCallback? onChange;
  const CustomSwitch({super.key,this.onChange});

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CustomSwitchCubit(),
      child: BlocBuilder<CustomSwitchCubit, bool>(
        builder: (context, isSwitched) {
          return GestureDetector(
            onTap: widget.onChange??() {
              context.read<CustomSwitchCubit>().toggleSwitch();
              context
                  .read<CreateItineraryCubit>()
                  .togglePlan(context.read<CustomSwitchCubit>().state);
            }, // Toggle Cubit state on tap

            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Container(
                    width: 47,
                    height: 23,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: AppColors.dividerColor,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.dividerColor.withValues(alpha: 0.1),
                          blurRadius: 10,
                          spreadRadius: 3,
                          offset: Offset(0, 3),
                        ),
                      ],
                    )),
                AnimatedPositioned(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  left: isSwitched ? 22 : 0,
                  // Move button
                  right: isSwitched ? 0 : 22,
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: AppColors.primaryNormal,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryNormal.withOpacity(0.4),
                          blurRadius: 8,
                          spreadRadius: 1,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
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
