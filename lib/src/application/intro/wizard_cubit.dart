import 'package:flutter_bloc/flutter_bloc.dart';

class WizardCubit extends Cubit<bool> {
  WizardCubit() : super(false);

  void triggerAnimation() {
    Future.delayed(Duration(milliseconds: 500), ()
    {
      emit(false);
      emit(true);
    });
  }

}