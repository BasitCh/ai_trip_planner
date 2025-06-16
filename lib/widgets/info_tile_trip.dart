import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:widgets_book/widgets_book.dart';

class InfoTileTrip extends StatelessWidget {
  final String label;
  final String value;

  const InfoTileTrip({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: AppColors.inputEnabled),
    ),
      color: AppColors.inputEnabled,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 17.0,horizontal: 34),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: titleXSmall?.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.w700
            )),
            Gap(5.w),

            Expanded(
              child: Text(value,
                  maxLines: 1,
                  style: titleXSmall?.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.w400
              )),
            ),
          ],
        ),
      ),
    );
  }
}