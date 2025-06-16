import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class TypographyPage extends StatelessWidget {
  const TypographyPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const TypographyPage());
  }

  @override
  Widget build(BuildContext context) {
    final uiTextStyleList = [
      // _TextItem(name: 'Display 2', style: UITextStyle.display2),
      // _TextItem(name: 'Display 3', style: UITextStyle.display3),
      _TextItem(name: 'Headline 1', style: UITextStyle.headline1),
      _TextItem(name: 'Headline 2', style: UITextStyle.headline2),
      _TextItem(name: 'Headline 3', style: UITextStyle.headline3),
      _TextItem(name: 'Headline 4', style: UITextStyle.headline4),
      _TextItem(name: 'Headline 5', style: UITextStyle.headline5),
      _TextItem(name: 'Headline 6', style: UITextStyle.headline6),
      _TextItem(name: 'Subtitle 1', style: UITextStyle.subtitle1),
      _TextItem(name: 'Subtitle 2', style: UITextStyle.subtitle2),
      _TextItem(name: 'Body Text 1', style: UITextStyle.bodyText1),
      _TextItem(name: 'Body Text 2', style: UITextStyle.bodyText2),
      _TextItem(name: 'Caption', style: UITextStyle.caption),
      _TextItem(name: 'Button', style: UITextStyle.button),
      _TextItem(name: 'Overline', style: UITextStyle.overline),
      _TextItem(name: 'Label Small', style: UITextStyle.labelSmall),
    ];

    final contentTextStyleList = [
      _TextItem(name: 'Headline 1', style: UITextStyle.headline1),
      _TextItem(name: 'Headline 2', style: UITextStyle.headline2),
      _TextItem(name: 'Headline 3', style: UITextStyle.headline3),
      _TextItem(name: 'Headline 4', style: UITextStyle.headline4),
      _TextItem(name: 'Headline 5', style: UITextStyle.headline5),
      _TextItem(name: 'Headline 6', style: UITextStyle.headline6),
      _TextItem(name: 'Subtitle 1', style: UITextStyle.subtitle1),
      _TextItem(name: 'Subtitle 2', style: UITextStyle.subtitle2),
      _TextItem(name: 'Body Text 1', style: UITextStyle.bodyText1),
      _TextItem(name: 'Body Text 2', style: UITextStyle.bodyText2),
      _TextItem(name: 'Caption', style: UITextStyle.caption),
      _TextItem(name: 'Button', style: UITextStyle.button),
      _TextItem(name: 'Overline', style: UITextStyle.overline),
      _TextItem(name: 'Label Small', style: UITextStyle.labelSmall),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Typography')),
      body: ListView(
        children: [
          const Center(child: Text('UI Typography')),
          const SizedBox(height: 16),
          ...uiTextStyleList,
          const SizedBox(height: 32),
          const Center(child: Text('Content Typography')),
          const SizedBox(height: 16),
          ...contentTextStyleList,
        ],
      ),
    );
  }
}

class _TextItem extends StatelessWidget {
  const _TextItem({required this.name, required this.style});

  final String name;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.lg,
      ),
      child: Text(name, style: style),
    );
  }
}
