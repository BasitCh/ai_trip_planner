import 'package:flutter/material.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:travel_hero/src/presentation/chat/widgets/date_chip/algo.dart';
import 'package:widgets_book/widgets_book.dart';

///[DateChip] use to show the date breakers on the chat view
///[date] parameter is required
///[color] parameter is optional default color code `8AD3D5`
///
///
class DateChip extends StatelessWidget {
  final DateTime date;
  final Color color;

  ///
  ///
  ///
  const DateChip({
    super.key,
    required this.date,
    this.color = const Color(0x558AD3D5),
  });
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 7,
          bottom: 7,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            color: color,
          ),

          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              Algo.dateChipText(date),
              style: titleMediumSaira?.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.onyx),
            ),
          ),
        ),
      ),
    );
  }
}