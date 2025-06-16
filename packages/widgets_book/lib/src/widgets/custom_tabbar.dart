import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({
    required this.selectedIndex,
    required this.tabTitles,
    required this.onTabSelected,
    this.isExpanded = true,
    this.tabBarDecoration,
    this.selectedColor,
    this.unselectedColor,
    this.tileBorderRadius,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.verticalPadding,
    super.key,
    this.padding,
  });

  const CustomTabBar.rounded({
    required this.selectedIndex,
    required this.tabTitles,
    required this.onTabSelected,
    this.selectedColor,
    this.unselectedColor = AppColors.tertiary600,
    this.tileBorderRadius = 28,
    this.isExpanded = false,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.verticalPadding,
    super.key,
    this.padding,
  }) : tabBarDecoration = const BoxDecoration();

  final int selectedIndex;
  final List<Widget> tabTitles;
  final Function(int) onTabSelected;
  final bool isExpanded;
  final BoxDecoration? tabBarDecoration;
  final Color? selectedColor;
  final EdgeInsetsGeometry? padding;
  final Color? unselectedColor;
  final double? tileBorderRadius;
  final MainAxisAlignment mainAxisAlignment;
  final double? verticalPadding;

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _colorAnimation = ColorTween(
      begin: AppColors.tertiary,
      end: AppColors.tertiary,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: widget.tabBarDecoration ??
          BoxDecoration(
            color: AppColors.white800,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColors.white800.withOpacity(0.6),
                spreadRadius: 3,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
      child: Row(
        mainAxisAlignment: widget.mainAxisAlignment,
        children: List.generate(
          widget.tabTitles.length,
          (index) => widget.isExpanded ? Expanded(child: _buildTabItem(index)) : _buildTabItem(index),
        ),
      ),
    );
  }

  Widget _buildTabItem(int index) {
    final isSelected = index == widget.selectedIndex;
    final color = isSelected ? widget.selectedColor ?? _colorAnimation.value : widget.unselectedColor ?? AppColors.white;
    final tileWidget = widget.tabTitles[index];

    return InkWell(
      onTap: () {
        widget.onTabSelected(index);
        _controller.forward(from: 0);
      },
      splashFactory: NoSplash.splashFactory,
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      child: Container(
        padding: widget.padding ??
            EdgeInsets.symmetric(vertical: 13.h, horizontal: 16.h),
        alignment: Alignment.center,
        margin: EdgeInsets.all(4.h),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(widget.tileBorderRadius ?? 10.h),
        ),
        child: tileWidget,
      ),
    );
  }
}
