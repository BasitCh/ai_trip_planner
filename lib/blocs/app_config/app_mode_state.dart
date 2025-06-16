part of 'app_mode_cubit.dart';
abstract class AppModeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AppModeInitial extends AppModeState {}

class AppModeLoading extends AppModeState {}

class AppModeLoaded extends AppModeState {
  final List<Mood> appModes;

  AppModeLoaded({required this.appModes});

  @override
  List<Object?> get props => [appModes];
}

class AppModeError extends AppModeState {
  final String message;

  AppModeError({required this.message});

  @override
  List<Object?> get props => [message];
}
