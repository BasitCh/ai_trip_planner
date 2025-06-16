import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_hero/repositories/user_repository.dart';
import 'package:travel_hero/src/application/splash/splash_cubit.dart';

class SplashBlocProvider extends StatelessWidget {
  const SplashBlocProvider({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(context.read<UserRepository>()),
      child: child,
    );
  }
}
