import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_hero/src/application/main/cubit/drawer_cubit.dart';
import 'package:travel_hero/src/application/main/cubit/main_navbar_cubit.dart';

enum AccountType { travelHero, traveler }

class AccountTypeCubit extends Cubit<AccountType> {
  AccountTypeCubit() : super(AccountType.travelHero);

  void switchAccount(AccountType account, BuildContext context) {
    context.read<DrawerCubit>().toggleMode();
    context.pop();
    context.read<MainNavBarCubit>().switchToHome();
    emit(account);
  }
}
