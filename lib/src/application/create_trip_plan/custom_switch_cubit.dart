import 'package:flutter_bloc/flutter_bloc.dart';

class CustomSwitchCubit extends Cubit<bool> {
  CustomSwitchCubit() : super(false); // Initial state: OFF

  void toggleSwitch() => emit(!state); // Toggle switch state
}