// ignore_for_file: comment_references, prefer_null_aware_method_calls, avoid_dynamic_calls, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:widgets_book/src/widgets/side_nav/src/global/global.dart';
import 'package:widgets_book/src/widgets/side_nav/src/side_menu_display_mode.dart';
import 'package:widgets_book/src/widgets/side_nav/src/side_menu_item.dart';
import 'package:widgets_book/src/widgets/side_nav/src/side_menu_style.dart';
import 'package:widgets_book/src/widgets/side_nav/src/side_menu_toggle.dart';

class SideMenu extends StatefulWidget {
  /// ### Easy Sidemenu widget
  ///
  /// Sidemenu is a menu that is usually located
  /// on the left or right of the page and can used for navigation
  const SideMenu({
    required this.items,
    required this.controller,
    super.key,
    this.title,
    this.footer,
    this.style,
    this.showToggle = false,
    this.onDisplayModeChanged,
    this.displayModeToggleDuration,
    this.alwaysShowFooter = false,
    this.collapseWidth = 600,
  });

  /// Page controller to control [PageView] widget
  final SideMenuController controller;

  /// List of [SideMenuItem] to show them on [SideMenu]
  final List<Widget> items;

  /// Title widget will shows on top of all items,
  /// it can be a logo or a Title text
  final Widget? title;

  /// Footer widget will show on bottom of [SideMenu]
  /// when [displayMode] was SideMenuDisplayMode.open
  final Widget? footer;

  /// [SideMenu] can be configured by this
  final SideMenuStyle? style;

  /// Show toggle button to switch between open and compact display mode
  /// If the display mode is auto, this button will not be displayed
  final bool? showToggle;

  /// By default footer only shown when display mode is open
  /// If you want always shown footer set it to true
  final bool? alwaysShowFooter;

  /// Notify when [SideMenuDisplayMode] changed
  final ValueChanged<SideMenuDisplayMode>? onDisplayModeChanged;

  /// Duration of [displayMode] toggling duration
  final Duration? displayModeToggleDuration;

  /// Width when will our open menu collapse into the compact one
  final int? collapseWidth;

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  double _currentWidth = 0;
  late bool showToggle;
  late bool alwaysShowFooter;
  late int collapseWidth;

  @override
  void initState() {
    super.initState();
    showToggle = widget.showToggle ?? false;
    alwaysShowFooter = widget.alwaysShowFooter ?? false;
    collapseWidth = widget.collapseWidth ?? 600;
  }

  @override
  void didUpdateWidget(covariant SideMenu oldWidget) {
    showToggle = widget.showToggle ?? false;
    alwaysShowFooter = widget.alwaysShowFooter ?? false;
    collapseWidth = widget.collapseWidth ?? 600;
    super.didUpdateWidget(oldWidget);
  }

  void _notifyParent() {
    if (widget.onDisplayModeChanged != null) {
      widget.onDisplayModeChanged!(Global.displayModeState.value);
    }
  }

  /// Set [SideMenu] width according to displayMode and notify parent widget
  double _widthSize(SideMenuDisplayMode mode, BuildContext context) {
    if (mode == SideMenuDisplayMode.auto) {
      if (MediaQuery.of(context).size.width > collapseWidth &&
          Global.displayModeState.value != SideMenuDisplayMode.open) {
        Global.displayModeState.change(SideMenuDisplayMode.open);
        _notifyParent();
        Future.delayed(_toggleDuration(), () {
          Global.showTrailing = true;
          for (final update in Global.itemsUpdate) {
            update();
          }
        });
        return Global.style.openSideMenuWidth ?? 300;
      }
      if (MediaQuery.of(context).size.width <= collapseWidth &&
          Global.displayModeState.value != SideMenuDisplayMode.compact) {
        Global.displayModeState.change(SideMenuDisplayMode.compact);
        _notifyParent();
        Global.showTrailing = false;
        return Global.style.compactSideMenuWidth ?? 50;
      }
      return _currentWidth;
    } else if (mode == SideMenuDisplayMode.open &&
        Global.displayModeState.value != SideMenuDisplayMode.open) {
      Global.displayModeState.change(SideMenuDisplayMode.open);
      Future.delayed(_toggleDuration(), () {
        Global.showTrailing = true;
        for (final update in Global.itemsUpdate) {
          update();
        }
      });
      _notifyParent();
      return Global.style.openSideMenuWidth ?? 300;
    }

    if (mode == SideMenuDisplayMode.compact) {
      if (Global.displayModeState.value != SideMenuDisplayMode.compact) {
        Global.displayModeState.change(SideMenuDisplayMode.compact);
        _notifyParent();
        Global.showTrailing = false;
      }

      return Global.style.compactSideMenuWidth ?? 50;
    }

    return _currentWidth;
  }

  Decoration _decoration(SideMenuStyle? menuStyle) {
    if (menuStyle == null || menuStyle.decoration == null) {
      return BoxDecoration(
        color: Global.style.backgroundColor,
      );
    } else {
      if (menuStyle.backgroundColor != null) {
        menuStyle.decoration =
            menuStyle.decoration!.copyWith(color: menuStyle.backgroundColor);
      }
      return menuStyle.decoration!;
    }
  }

  Duration _toggleDuration() {
    return widget.displayModeToggleDuration ??
        const Duration(milliseconds: 350);
  }

  @override
  Widget build(BuildContext context) {
    Global.controller = widget.controller;
    // widget.items.sort((a, b) => a.priority.compareTo(b.priority));
    Global.style = widget.style ?? SideMenuStyle();
    _currentWidth = _widthSize(
        Global.style.displayMode ?? SideMenuDisplayMode.auto, context,);

    return AnimatedContainer(
      duration: _toggleDuration(),
      width: _currentWidth,
      height: MediaQuery.of(context).size.height,
      decoration: _decoration(widget.style),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                if (Global.style.displayMode == SideMenuDisplayMode.compact &&
                    showToggle)
                  const SizedBox(
                    height: 42,
                  ),
                if (widget.title != null) widget.title!,
                ...widget.items,
              ],
            ),
          ),
          if ((widget.footer != null &&
                  Global.displayModeState.value !=
                      SideMenuDisplayMode.compact) ||
              (widget.footer != null && alwaysShowFooter))
            Align(alignment: Alignment.bottomCenter, child: widget.footer),
          if (Global.style.displayMode != SideMenuDisplayMode.auto &&
              showToggle)
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal:
                      Global.displayModeState.value == SideMenuDisplayMode.open
                          ? 0
                          : 4,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SideMenuToggle(
                    onTap: () {
                      if (Global.displayModeState.value ==
                          SideMenuDisplayMode.compact) {
                        setState(() {
                          Global.style.displayMode = SideMenuDisplayMode.open;
                        });
                      } else if (Global.displayModeState.value ==
                          SideMenuDisplayMode.open) {
                        setState(() {
                          Global.style.displayMode =
                              SideMenuDisplayMode.compact;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    Future.delayed(Duration.zero, () {
      Global.displayModeState.change(Global.displayModeState.value);
    });
    super.dispose();
  }
}
