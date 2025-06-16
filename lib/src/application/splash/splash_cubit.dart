import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_hero/global/navigation.dart';
import 'package:travel_hero/repositories/user_repository.dart';
import 'package:travel_hero/src/application/login_register/app_user_cubit.dart';
import 'package:travel_hero/src/infrastructure/di/injectable.dart';
import 'package:travel_hero/src/infrastructure/routes/app_routes.dart';
import 'package:travel_hero/src/infrastructure/services/navigation_service.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this._userRepository,) : super(SplashInitial()) {
    _splashCubitStreamSubscription = stream.listen(_onSplashStateUpdated);
    _checkUser();
  }
  final UserRepository _userRepository;
  late final StreamSubscription _splashCubitStreamSubscription;

  Future<void> _checkUser() async {
    final user = await _userRepository.fetch();
    user.fold((error) {
      emit(SplashError(error.toString()));
    }, (appUser) async {
      if (appUser != null) {
        Navigation.router.routerDelegate.navigatorKey.currentContext!.read<AppUserCubit>().setUser(appUser);
        // await initializeUser(Navigation.router.routerDelegate.navigatorKey.currentContext!);
        emit(SplashUserAuthenticated());
      } else {
        emit(SplashUserUnAuthenticated());
      }
    });
    //emit(SplashUserUnAuthenticated());
  }

  void _onSplashStateUpdated(SplashState state) async {
    if (state is SplashUserUnAuthenticated || state is SplashError) {
    final context =
        Navigation.router.routerDelegate.navigatorKey.currentContext;
    if (context == null) return;
    await Future.delayed(const Duration(milliseconds: 1000));
    getIt<NavigationService>().replaceWithNamed(
        context: context, uri: NavigationPath.wizardRouteUri);
    } else if (state is SplashUserAuthenticated) {
      final context =
          Navigation.router.routerDelegate.navigatorKey.currentContext;
      if (context == null) return;
      getIt<NavigationService>().replaceWithNamed(context: context, uri: NavigationPath.homeRouteUri);
    }
  }

  @override
  Future<void> close() {
    _splashCubitStreamSubscription.cancel();
    return super.close();
  }
}
