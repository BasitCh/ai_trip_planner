import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;

  const HeaderWidget({required this.title, this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (onBack != null)
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: onBack,
          ),
        Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}