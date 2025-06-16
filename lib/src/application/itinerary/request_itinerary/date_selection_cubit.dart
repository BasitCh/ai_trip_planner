import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_hero/src/application/itinerary/request_itinerary/date_selection_state.dart';
import 'package:travel_hero/src/application/itinerary/request_itinerary/itinerary_request_cubit.dart';

class MonthModel {
  final String name;
  final bool isSelected;

  MonthModel({required this.name, this.isSelected = false});

  // **Toggle selection state**
  MonthModel toggleSelection() {
    return MonthModel(name: name, isSelected: !isSelected);
  }
}

class DateSelectionCubit extends Cubit<DateSelectionState> {
  DateSelectionCubit()
      : super(DateSelectionState(
          dateSelectionMethod: DateSelectionMethod.range,
          startDate: null,
          endDate: null,
          focusedDay: DateTime.now(),
          dayCounter: 3,
          selectedMonths: _generateMonths(),
        ));

  // **Generate List of Months**
  static List<MonthModel> _generateMonths() {
    DateTime now = DateTime.now();
    return List.generate(12, (i) {
      DateTime month = DateTime(now.year, now.month + i, 1);
      return MonthModel(name: _monthName(month.month));
    });
  }

  static String _monthName(int month) {
    const monthNames = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    return monthNames[month - 1];
  }

  /// **Switch Between "Date Range" & "Trip Length" Mode**
  void toggleSelectionMode(BuildContext context, DateSelectionMethod method) {
    context.read<ItineraryRequestCubit>().toggleDateSelectionMethod(method);

    emit(state.copyWith(
      dateSelectionMethod: method,
      startDate: null,
      endDate: null,
      dayCounter: 1,
      selectedMonths: _generateMonths(),
    ));
  }

  /// **User selects a start & end date**
  void updateDateRange(DateTime start, DateTime end, DateTime focusedDay, BuildContext context) {
  emit(state.copyWith(
    startDate: start,
    endDate: end,
    focusedDay: focusedDay,
  ));
  context.read<ItineraryRequestCubit>().updateDates(start, end);
}

  /// **Select a month when "Trip Length Mode" is active**
  // void toggleMonthSelection(String month, BuildContext context) {
  //   List<MonthModel> updatedMonths = state.selectedMonths.map((m) {
  //     return m.name == month ? m.toggleSelection() : m;
  //   }).toList();
  //
  //   // Find selected month
  //   String? selectedMonth = updatedMonths
  //       .firstWhere((m) => m.isSelected, orElse: () => MonthModel(name: ""))
  //       .name;
  //
  //   // Update selected month in RequestTripPlanCubit
  //   if (selectedMonth.isNotEmpty) {
  //     context.read<ItineraryRequestCubit>().updateSelectedMonth(selectedMonth);
  //   }
  //
  //   emit(state.copyWith(selectedMonths: updatedMonths));
  // }
  void toggleMonthSelection(String month, BuildContext context) {
    List<MonthModel> updatedMonths = state.selectedMonths.map((m) {
      return MonthModel(name: m.name, isSelected: m.name == month);
    }).toList();


    // Find the newly selected month
    String? selectedMonth = updatedMonths
        .firstWhere((m) => m.isSelected, orElse: () => MonthModel(name: ""))
        .name;

    // Update selected month in RequestTripPlanCubit
    if (selectedMonth.isNotEmpty) {
      context.read<ItineraryRequestCubit>().updateSelectedMonth(selectedMonth);
    }

    emit(state.copyWith(selectedMonths: updatedMonths));
  }
  /// **Increase trip length**
  void incrementCounter(BuildContext context) {
    context
        .read<ItineraryRequestCubit>()
        .updateTripLength(state.dayCounter + 1);
    emit(state.copyWith(dayCounter: state.dayCounter + 1));
  }

  /// **Decrease trip length**
  void decrementCounter(BuildContext context) {
    if (state.dayCounter > 1) {
      context
          .read<ItineraryRequestCubit>()
          .updateTripLength(state.dayCounter - 1);
      emit(state.copyWith(dayCounter: state.dayCounter - 1));
    }
  }

  /// **Check if trip details are valid before proceeding**
  bool allSet() {
    if (state.dateSelectionMethod == DateSelectionMethod.length) {
      bool isMonthSelected = state.selectedMonths.any((m) => m.isSelected);
      return isMonthSelected && state.dayCounter > 0;
    } else {
      return state.startDate != null && state.endDate != null;
    }
  }
}
