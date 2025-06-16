import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_hero/src/infrastructure/utils/base_bottom_sheet.dart';
import 'package:widgets_book/widgets_book.dart';

import 'modal_bloc.dart';

class ModalWidget extends StatelessWidget {
  final Widget child;
  const ModalWidget({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ModalBloc, ModalState>(
      listener: _modalBlockListener,
      child: child,
    );
  }

  void _modalBlockListener(BuildContext context, ModalState state) {
    if (state is ShowGeneralDialog) {
      _showGeneralDialog(context, state);
    } else if (state is ShowBaseBottomSheet) {
      _showBaseBottomSheet(context, state);
    } else if (state is ShowNoNavBarBottomSheet) {
      _showNoNavBarBottomSheet(context, state);
    } else if (state is ModalInitial) {
      context.pop();
    }
  }

  _showGeneralDialog(BuildContext context, ShowGeneralDialog state) async {
    final modalBloc = context.read<ModalBloc>();

    await showGeneralDialog(
      context: context,
      barrierColor: Colors.black12.withOpacity(0.6), // Background color
      barrierDismissible: false,
      pageBuilder: (_, __, ___) => state.widget,
      transitionDuration: const Duration(milliseconds: 600),
    );
    modalBloc.add(ModalPopped());
  }

  _showBaseBottomSheet(BuildContext context, ShowBaseBottomSheet state) async {
    final modalBloc = context.read<ModalBloc>();

    await baseBottomSheet(
      context: context,
      userRootNavigator: true,
      title: state.title,
      padding: EdgeInsets.fromLTRB(0, 20.h, 0, 0.h),
      content: state.widget,
      bottomWidget: state.bottomWidget,
      trailingWidget: state.trailingWidget,
      bottomSheetHeight: state.bottomSheetHeight,
      onClose: state.onClose,
    );
    modalBloc.add(ModalPopped());
  }

  _showNoNavBarBottomSheet(
      BuildContext context, ShowNoNavBarBottomSheet state) async {
    final modalBloc = context.read<ModalBloc>();

    await noNavBarBottomSheet(
      context: context,
      builder: (context) {
        return state.widget;
      },
      trailingWidget: state.trailingWidget,
    );
    modalBloc.add(ModalPopped());
  }
}
