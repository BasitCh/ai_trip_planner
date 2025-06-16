import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:travel_hero/src/application/itinerary/request_itinerary/itinerary_request_cubit.dart';
import 'package:travel_hero/src/domain/itinerary/itinerary_request.dart';
import 'package:widgets_book/widgets_book.dart';

class DateSelectionCalenderReadOnly extends StatelessWidget {
  const DateSelectionCalenderReadOnly({
    super.key,
     this.tripPlanState,
    this.itineraryRequest,
  });

  final ItineraryRequestState? tripPlanState;
  final ItineraryRequest? itineraryRequest;

  @override
  Widget build(BuildContext context) {
    DateTime? start =
        _convertTimestamp(itineraryRequest!=null?itineraryRequest!.startDate:tripPlanState!.itineraryRequest.startDate);
    DateTime? end = _convertTimestamp(itineraryRequest!=null?itineraryRequest!.endDate:tripPlanState!.itineraryRequest.endDate);
    DateTime today = DateTime.now();

    return IgnorePointer(
      ignoring: true,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        shadowColor: const Color.fromRGBO(23, 37, 76, 0.12),
        color: const Color.fromRGBO(255, 255, 255, 1),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: TableCalendar(
            rangeSelectionMode:
                RangeSelectionMode.enforced, // Enable range selection
            rangeStartDay: start,
            rangeEndDay: end,
            availableGestures: AvailableGestures.horizontalSwipe,
            focusedDay: start ?? today,
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekendStyle: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: AppColors.slateGray),
              weekdayStyle: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: AppColors.slateGray),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkBlueNew),
              leftChevronIcon:
                  const Icon(Icons.chevron_left, color: AppColors.darkBlueNew),
              rightChevronIcon:
                  const Icon(Icons.chevron_right, color: AppColors.darkBlueNew),
            ),
calendarStyle: CalendarStyle(
            todayDecoration:
                BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
            selectedDecoration: BoxDecoration(
                color: AppColors.primary.withAlpha((0.50 * 255).toInt()),
                shape: BoxShape.circle),
            defaultTextStyle:
                const TextStyle(color: AppColors.darkBlueNew, fontSize: 13),
            weekendTextStyle:
                const TextStyle(color: AppColors.slateGray, fontSize: 13),
            outsideTextStyle: TextStyle(
                color: AppColors.deepNavy.withAlpha((0.32 * 255).toInt()), fontSize: 13),
            rangeStartDecoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            rangeEndDecoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            rangeHighlightColor: AppColors.primary.withAlpha((0.2 * 255).toInt()),
            withinRangeTextStyle: const TextStyle(
              color: AppColors.darkBlueNew,
              fontWeight: FontWeight.w600,
            ),
          ),
            selectedDayPredicate: (day) =>
                false, // Not needed for range selection
            onRangeSelected: (start, end, focusedDay) {},
          ),
        ),
      ),
    );
  }

  /// Convert `Timestamp` to `DateTime`
  DateTime? _convertTimestamp(Timestamp? timestamp) {
    return timestamp?.toDate();
  }
}
