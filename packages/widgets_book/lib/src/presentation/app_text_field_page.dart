import 'package:flutter/material.dart';
import 'package:widgets_book/src/widgets/text_field/app_search_text_field.dart';
import 'package:widgets_book/widgets_book.dart';

class NaTextFieldPage extends StatelessWidget {
  const NaTextFieldPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const NaTextFieldPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Text Field',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            const AppEmailTextField(),
            AppTextField(
              hintText: 'Default text field',
              onChanged: (_) {},
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            const AppSearchTextField(),
            const SizedBox(
              height: 20,
            ),
            const AppStandardTextField(
              hintText: 'underline text field',
            ),
          ],
        ),
      ),
    );
  }
}
