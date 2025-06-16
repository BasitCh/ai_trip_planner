import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class AppPopUpMenuButton<T> extends StatelessWidget {
  const AppPopUpMenuButton({
    required this.itemBuilder,
    super.key,
    this.onSelected,
    this.color = AppColors.accent,
    this.child,
    this.offset = const Offset(0, -110),
  });

  final void Function(T)? onSelected;
  final Color color;
  final List<PopupMenuEntry<T>> Function(BuildContext) itemBuilder;
  final Widget? child;
  final Offset offset;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<T>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      splashRadius: 1,
      onSelected: onSelected,
      offset: offset,
      color: color,
      tooltip: '',
      itemBuilder: itemBuilder,
      child: child ??
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: const Icon(
              Icons.menu_sharp,
            ),
          ),
    );
  }
}
