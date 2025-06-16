import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class BaseScaffold extends StatelessWidget {
  const BaseScaffold({
    super.key,
    this.backgroundColor = AppColors.white,
    this.drawerIconColor,
    this.appBar,
    this.body,
    this.extendBodyBehindAppBar,
    this.resizeToAvoidBottomInset = false,
  });
  final Widget? appBar;
  final Widget? body;
  final Color? backgroundColor;
  final Color? drawerIconColor;
  final bool? resizeToAvoidBottomInset;
  final bool? extendBodyBehindAppBar;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      extendBodyBehindAppBar: extendBodyBehindAppBar??false,
      backgroundColor: backgroundColor,
      appBar: appBar != null
          ? PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: appBar!,
        
            )
          : null,
      body: Stack(
        children: [
          if (body != null) body!,
        ],
      ),
    );
  }
}
