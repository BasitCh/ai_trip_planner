part of 'snack_bar_cubit.dart';

@immutable
sealed class SnackBarState {}

final class SnackBarInitial extends SnackBarState {}

final class ShowSnackBar extends SnackBarState {
  final String message;
  final int milliseconds;

  ShowSnackBar(this.message, {this.milliseconds = 1500});
}
