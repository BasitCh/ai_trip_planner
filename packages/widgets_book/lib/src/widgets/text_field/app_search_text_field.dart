import 'package:flutter/material.dart';

class AppSearchTextField extends StatelessWidget {
  const AppSearchTextField({super.key, this.onChanged});

  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextField(
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.search,
          size: 25,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: theme.highlightColor,
          ), //<-- SEE HERE
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: theme.primaryColor,
          ), //<-- SEE HERE
        ),
        labelText: 'Work as / for',
      ),
    );
  }
}
