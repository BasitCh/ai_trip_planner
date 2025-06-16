
import 'package:flutter_bloc/flutter_bloc.dart';

class LoaderCubit extends Cubit<int> {
  LoaderCubit() : super(0);

  void nextStep() {
    emit((state + 1) % 3); // Cycle through 1 → 4 → 9.
  }
}