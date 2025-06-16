// Reusable Widget: Info Card
import 'package:flutter/material.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:widgets_book/widgets_book.dart';

class InfoCard extends StatelessWidget {
  final String label;
  final String amount;
  final Color color;
final BorderRadiusGeometry? borderRadiusGeometry;
  const InfoCard({
    super.key,
    required this.label,
    required this.amount,
    required this.color,
    this.borderRadiusGeometry,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: borderRadiusGeometry?? BorderRadius.only(
            topLeft: Radius.circular(8.0),
            bottomLeft: Radius.circular(8.0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Text(
              label,
              style: titleXSmallWhite?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.lightBlackText,
                fontSize: 20.sp,
              ),
            ),
            Text(
              amount,
              style: titleXSmallWhite?.copyWith(
                fontWeight: FontWeight.w700,
                color: color,
                fontSize: 21.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}