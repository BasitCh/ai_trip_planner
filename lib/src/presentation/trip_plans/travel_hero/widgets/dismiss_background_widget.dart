import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class DismissBackgroundWidget extends StatelessWidget {
  const DismissBackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.red800,
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: const Icon(Icons.delete, color: Colors.white),
    );
  }
}
