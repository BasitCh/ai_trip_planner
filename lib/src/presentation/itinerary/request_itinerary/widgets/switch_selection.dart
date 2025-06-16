

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_hero/src/application/itinerary/request_itinerary/date_selection_cubit.dart';
import 'package:travel_hero/src/application/itinerary/request_itinerary/date_selection_state.dart';
import 'package:travel_hero/src/application/itinerary/request_itinerary/itinerary_request_cubit.dart';
import 'package:travel_hero/src/presentation/itinerary/request_itinerary/widgets/date_selection_calender.dart';
import 'package:travel_hero/src/presentation/itinerary/request_itinerary/widgets/trip_length_selection.dart';

class SwitchSelection extends StatelessWidget {
  const SwitchSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DateSelectionCubit, DateSelectionState>(
      builder: (context, state) {
        return state.dateSelectionMethod == DateSelectionMethod.range
            ? DateSelectionCalender(dateSelectionState: state,)
            : Center(
          child: TripLengthSelection(),
        );
      },
    );
  }
}
