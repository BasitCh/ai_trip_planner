import 'package:flutter/material.dart';

class PlanToggleWidget extends StatelessWidget {
  final bool isPaidPlan;
  final ValueChanged<bool> onChanged;

  const PlanToggleWidget({required this.isPaidPlan, required this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Free Trip Plan'),
        Switch(
          value: isPaidPlan,
          onChanged: onChanged,
        ),
        Text('Paid Trip Plan'),
      ],
    );
  }
}