
import 'package:equatable/equatable.dart';
import 'package:travel_hero/src/application/itinerary/request_itinerary/date_selection_cubit.dart';
import 'package:travel_hero/src/application/itinerary/request_itinerary/itinerary_request_cubit.dart';

class DateSelectionState extends Equatable {
  final DateSelectionMethod dateSelectionMethod;
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime focusedDay;
  final int dayCounter;
  final List<MonthModel> selectedMonths;

  const DateSelectionState({
    required this.dateSelectionMethod,
    this.startDate,
    this.endDate,
    required this.focusedDay,
    required this.dayCounter,
    required this.selectedMonths,
  });

  DateSelectionState copyWith({
    DateSelectionMethod? dateSelectionMethod,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? focusedDay,
    int? dayCounter,
    List<MonthModel>? selectedMonths,
  }) {
    return DateSelectionState(
      dateSelectionMethod: dateSelectionMethod ?? this.dateSelectionMethod,
      startDate: startDate,
      endDate: endDate,
      focusedDay: focusedDay ?? this.focusedDay,
      dayCounter: dayCounter ?? this.dayCounter,
      selectedMonths: selectedMonths ?? this.selectedMonths,
    );
  }

  @override
  List<Object?> get props => [
        dateSelectionMethod,
        startDate,
        endDate,
        focusedDay,
        dayCounter,
        selectedMonths,
      ];
}
