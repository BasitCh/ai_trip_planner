import 'package:flutter/material.dart';
import 'package:widgets_book/src/widgets/checkbox/app_checkbox.dart';

class AppCheckBoxPage extends StatefulWidget {
  const AppCheckBoxPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const AppCheckBoxPage());
  }

  @override
  State<AppCheckBoxPage> createState() => _AppCheckBoxPageState();
}

class _AppCheckBoxPageState extends State<AppCheckBoxPage> {
  bool? isChecked = false;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppCheckBox(
              value: isChecked,
              activeColor: themeData.primaryColor,
              onChanged: (value) {
                setState(() {
                  isChecked = value ?? false;
                });
              },
            ),
            AppCheckBox(
              value: false,
              activeColor: themeData.primaryColor,
              onChanged: (value) {},
            ),
            AppCheckBox(
              onChanged: (value) {},
            ),
          ],
        ),
      ),
    );
  }
}
