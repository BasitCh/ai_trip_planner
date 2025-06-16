
import 'package:flutter_bloc/flutter_bloc.dart';

class TripCardCubit extends Cubit<Map<int, bool>> {
  TripCardCubit() : super({}); // Keeps track of expanded tiles

  void toggleExpansion(int index) {
    final newState = Map<int, bool>.from(state);
    newState[index] = !(state[index] ?? true);
    emit(newState);
  }
}