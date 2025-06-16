import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class AppCameraPage extends StatefulWidget {
  const AppCameraPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const AppCameraPage());
  }

  @override
  State<AppCameraPage> createState() => _AppCameraPageState();
}

class _AppCameraPageState extends State<AppCameraPage> {
  bool? isChecked = false;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppCamera(
              onFileSelected: (String? value) {},
            ),
          ],
        ),
      ),
    );
  }
}
