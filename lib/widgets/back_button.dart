import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:widgets_book/widgets_book.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key, this.style});

  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const AppBackButton(),
        const Gap(16),
        Text(localizations.back, style: style ?? titleMediumSourceSerif),
      ],
    );
  }
}
