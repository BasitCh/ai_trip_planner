import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_hero/blocs/snack_bar/snack_bar_cubit.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:widgets_book/widgets_book.dart';

class SnackBarWidget extends StatelessWidget {
  final Widget child;
  const SnackBarWidget({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SnackBarCubit, SnackBarState>(
      listener: _snackbarBlocListener,
      child: child,
    );
  }

  void _snackbarBlocListener(BuildContext context, SnackBarState state) {
    if (state is ShowSnackBar) {
      ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(
        SnackBar(
          backgroundColor: AppColors.secondary,
          duration: Duration(milliseconds: state.milliseconds),
          content: Text(
            state.message,
            overflow: TextOverflow.visible,
            textAlign: TextAlign.center,
            style: bodyMedium?.copyWith(color: AppColors.backgroundColor),
          ),
        ),
      );
    }
  }
}
