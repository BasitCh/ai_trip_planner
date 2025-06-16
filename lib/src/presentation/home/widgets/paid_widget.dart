import 'package:flutter/material.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:widgets_book/widgets_book.dart';

class PaidWidget extends StatelessWidget {
  const PaidWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        'Paid',
        style: selectedLabel?.copyWith(
          color: AppColors.white,
        ),
      ),
    );
  }
}
