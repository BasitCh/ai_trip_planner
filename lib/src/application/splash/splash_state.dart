part of 'splash_cubit.dart';

class SplashState extends Equatable{
  @override
  List<Object?> get props => [];
}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashUserAuthenticated extends SplashState {}

class SplashUserUnAuthenticated extends SplashState {}

class SplashError extends SplashState {
  SplashError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}
