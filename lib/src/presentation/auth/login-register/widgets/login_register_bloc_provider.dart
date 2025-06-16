import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_hero/blocs/snack_bar/snack_bar_cubit.dart';
import 'package:travel_hero/repositories/user_repository.dart';
import 'package:travel_hero/src/application/login_register/login_register_cubit.dart';
import 'package:travel_hero/src/infrastructure/login_register/login_register_repository.dart';
import 'package:travel_hero/src/infrastructure/social_login/social_login_repository.dart';

class LoginRegisterBlocProvider extends StatelessWidget {
  const LoginRegisterBlocProvider({required this.child, super.key});

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return  BlocProvider<LoginRegisterCubit>(
      create: (context) => LoginRegisterCubit(
          context.read<SnackBarCubit>(),
          RepositoryProvider.of<LoginRegisterRepository>(context),
          RepositoryProvider.of<UserRepository>(context),
          RepositoryProvider.of<SocialLoginRepository>(context)),
          child: child
    );
  }
}
