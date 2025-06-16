// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:widgets_book/src/presentation/app_back_button_page.dart';
import 'package:widgets_book/src/presentation/app_button_page.dart';
import 'package:widgets_book/src/presentation/app_camera_page.dart';
import 'package:widgets_book/src/presentation/app_checbook_page.dart';
import 'package:widgets_book/src/presentation/app_logo_page.dart';
import 'package:widgets_book/src/presentation/app_switch_page.dart';
import 'package:widgets_book/src/presentation/app_text_field_page.dart';
import 'package:widgets_book/src/presentation/show_app_modal_page.dart';

class WidgetsPage extends StatelessWidget {
  const WidgetsPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const WidgetsPage());
  }

  @override
  Widget build(BuildContext context) {
    final widgets = <_ListItem>[
      _ListItem(
        icon: const Icon(Icons.input),
        title: const Text('Logo'),
        onTap: () => Navigator.of(context).push<void>(AppLogoPage.route()),
      ),
      _ListItem(
        icon: const Icon(Icons.vignette),
        title: const Text('App Buttons'),
        onTap: () => Navigator.of(context).push<void>(AppButtonPage.route()),
      ),
      _ListItem(
        icon: const Icon(Icons.ad_units_rounded),
        title: const Text('Show Modal'),
        onTap: () => Navigator.of(context).push<void>(ShowAppModalPage.route()),
      ),
      _ListItem(
        icon: const Icon(Icons.email_outlined),
        title: const Text('Text Fields'),
        onTap: () => Navigator.of(context).push<void>(NaTextFieldPage.route()),
      ),
      _ListItem(
        icon: const Icon(Icons.arrow_back_ios),
        title: const Text('App Back Button'),
        onTap: () =>
            Navigator.of(context).push<void>(AppBackButtonPage.route()),
      ),
      _ListItem(
        icon: const Icon(Icons.switch_left),
        title: const Text('App Switch'),
        onTap: () => Navigator.of(context).push<void>(NaSwitchPage.route()),
      ),
      _ListItem(
        icon: const Icon(Icons.check_box),
        title: const Text('Check Box'),
        onTap: () => Navigator.of(context).push<void>(AppCheckBoxPage.route()),
      ),
      _ListItem(
        icon: const Icon(Icons.camera_alt_outlined),
        title: const Text('Camera '),
        onTap: () => Navigator.of(context).push<void>(AppCameraPage.route()),
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Widgets')),
      body: ListView.separated(
        itemCount: widgets.length,
        itemBuilder: (_, index) => widgets[index],
        separatorBuilder: (_, __) => const Divider(),
      ),
    );
  }
}

class _ListItem extends StatelessWidget {
  const _ListItem({required this.icon, required this.title, this.onTap});

  final VoidCallback? onTap;
  final Widget icon;
  final Text title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: title,
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
