import 'package:flutter/material.dart';

class DayPlanCard extends StatelessWidget {
  final String day;
  final String? details;
  final VoidCallback? onEdit;

  const DayPlanCard({required this.day, this.details, this.onEdit, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(day),
      subtitle: Text(details ?? 'Click to add a destination'),
      trailing: IconButton(
        icon: Icon(Icons.edit),
        onPressed: onEdit,
      ),
    );
  }
}