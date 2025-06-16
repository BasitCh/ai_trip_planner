import 'package:flutter/material.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:widgets_book/widgets_book.dart';

class PromptCard extends StatelessWidget {
  const PromptCard({
    super.key,
    required this.title,
    required this.color,
  });
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8,),
      padding: EdgeInsets.symmetric(vertical: 12,horizontal: 30),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),

      child: Text(
        title,
        style: titleXSmall?.copyWith(fontSize: 13.sp,fontWeight: FontWeight.w600,color: AppColors.black),
      ),
    );
  }
}