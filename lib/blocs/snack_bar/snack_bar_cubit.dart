import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'snack_bar_state.dart';

class SnackBarCubit extends Cubit<SnackBarState> {
  SnackBarCubit() : super(SnackBarInitial());

  showSnackBar(String message, {int milliseconds = 5000}) {
    emit(ShowSnackBar(message, milliseconds: milliseconds));
  }
}
