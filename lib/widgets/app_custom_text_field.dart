import 'package:flutter/material.dart';

class CustomTextFieldExample extends StatelessWidget {
  const CustomTextFieldExample({super.key,this.onChanged});
  final Function(String value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 3, // Allows multiline input
      onChanged: onChanged,

      decoration: InputDecoration(
        labelText: 'Enter Text',
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        hintText:
        'Create a hiking and camping Trip Plan for two in the Bangkok, Thailand. The trip should be for 7 days, starting from 3rd August 2024',
        hintStyle: TextStyle(
          fontSize: 14,
          color: Colors.grey[400],
        ),
        filled: true, // Adds light background color
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0), // Rounded corners
          borderSide: BorderSide(
            color: Colors.grey, // Border color
            width: 0.5, // Thin border
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            color: Colors.grey, // Border color when enabled
            width: 0.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            color: Colors.blue, // Border color when focused
            width: 1.0,
          ),
        ),
      ),
    );
  }
}
