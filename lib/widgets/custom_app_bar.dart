import 'package:flutter/material.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:widgets_book/widgets_book.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({this.title, this.titleText,this.centerTitle, this.actions, super.key}) : assert(title != null || titleText != null);

  final Widget? title;
  final String? titleText;
  final List<Widget>? actions;
  final bool? centerTitle;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        leadingWidth: 80,
        toolbarHeight: 80,
        centerTitle: centerTitle??true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: title ?? Text(titleText ?? '', style: titleXMediumSourceSerif?.copyWith(fontSize: 16.sp)),
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
