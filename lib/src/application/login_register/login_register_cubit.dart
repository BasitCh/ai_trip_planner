import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_hero/blocs/snack_bar/snack_bar_cubit.dart';
import 'package:travel_hero/global/navigation.dart';
import 'package:travel_hero/repositories/user_repository.dart';
import 'package:travel_hero/src/application/login_register/app_user_cubit.dart';
import 'package:travel_hero/src/domain/login_register/app_user.dart';
import 'package:travel_hero/src/domain/login_register/login_register_request.dart';
import 'package:travel_hero/src/infrastructure/login_register/login_register_repository.dart';
import 'package:travel_hero/src/infrastructure/routes/app_routes.dart';
import 'package:travel_hero/src/infrastructure/services/navigation_service.dart';
import 'package:travel_hero/src/infrastructure/social_login/social_login_repository.dart';
import 'package:travel_hero/src/infrastructure/utils/enum.dart';
import 'package:widgets_book/widgets_book.dart';

part 'login_register_state.dart';

class LoginRegisterCubit extends Cubit<LoginRegisterState> {
  LoginRegisterCubit(this._snackBarCubit, this._loginRegisterRepository, this._userRepository, this._socialLoginRepository) : super(LoginRegisterState()) {
    _signupStreamSubscription = stream.listen(onSignupStateUpdated);
  }
  final SnackBarCubit _snackBarCubit;
  final LoginRegisterRepository _loginRegisterRepository;
  final UserRepository _userRepository;
  final SocialLoginRepository _socialLoginRepository;

  late StreamSubscription<LoginRegisterState> _signupStreamSubscription;

  LoginRegisterMethod? _loginRegisterMethod;

  void signUpWithEmailAndPassword(LoginRegisterRequest loginRegisterRequest) async {
    if (state.isTermsAgreed != null && (state.isTermsAgreed ?? true)) {
      emit(state.copyWith(isSocial: false, isSubmitting: true, authFailureOrSuccessOption: none()));
      final response = await _loginRegisterRepository.signUpWithEmail(loginRegisterRequest);
      _loginRegisterMethod = LoginRegisterMethod.email;
      emit(state.copyWith(authFailureOrSuccessOption: optionOf(response), isSubmitting: false));
    }
  }

  void showValidationError() {
    if (state.isTermsAgreed == null) {
      emit(state.copyWith(isTermsAgreed: false, authFailureOrSuccessOption: none()));
    }
  }

  void signUpWithSocial(LoginRegisterMethod loginRegisterMethod) async {
    emit(state.copyWith(isSubmitting: true, isSocial: true, authFailureOrSuccessOption: none()));
    late Either<ApiError, User?> response;
    if(loginRegisterMethod== LoginRegisterMethod.google) {
      response = await _socialLoginRepository.loginWithGoogle();
    }else if(loginRegisterMethod== LoginRegisterMethod.apple){
      response = await _socialLoginRepository.loginWithApple();
    }else{
      response = await _socialLoginRepository.loginWithFaceBook();
    }
    _loginRegisterMethod = loginRegisterMethod;
    emit(state.copyWith(authFailureOrSuccessOption: optionOf(response), isSubmitting: false));
  }

  void onSignupStateUpdated(LoginRegisterState state) {
    state.authFailureOrSuccessOption?.fold(() {}, (signup) async {
      await signup.fold((error) {
        final errorMessage = error.message;
        if (errorMessage != null) _snackBarCubit.showSnackBar(errorMessage);
      }, (user) async {
        if (state.isSocial) {
          _getUser(user);
        } else {
          await _createUser(user);
        }
      });
    });
  }

  Future<void> _getUser(User? user) async {
    final response = await _userRepository.fetchFromApi();
    response.fold((error) {
      if (error.toString().toLowerCase().contains('no user found') || error is UserDataNotCreatedYet) {
        _createUser(user);
      } else {
        _snackBarCubit.showSnackBar(error.toString());
      }
    }, (success) async {
      Navigation.router.routerDelegate.navigatorKey.currentContext!.read<AppUserCubit>().setUser(success);
      final currentContext = Navigation.router.routerDelegate.navigatorKey.currentContext;
      if (currentContext != null) currentContext.replaceNamed(NavigationPath.homeRouteUri);
    });
  }
  Future<void> _createUser(User? user) async {
    final response = await _userRepository.createUser(AppUser(
      userEmail: user?.email,
      isEmailVerified: user?.emailVerified,
      pictureUrl: user?.photoURL,
      creationDate: Timestamp.now(),
      signupMethod: _loginRegisterMethod,
      username: _loginRegisterMethod == LoginRegisterMethod.google? user?.displayName: null,
    ));
    response.fold((error) {
      _snackBarCubit.showSnackBar(error.message ?? 'Error');
    }, (success) async {
      if (state.isSocial) {
        Navigation.router.routerDelegate.navigatorKey.currentContext!.read<AppUserCubit>().setUser(success);
        final currentContext = Navigation.router.routerDelegate.navigatorKey.currentContext;
        if (currentContext != null) currentContext.replaceNamed(NavigationPath.homeRouteUri);
      } else {
        //await _sendEmailVerificationLink();
      }
    });
  }

  // Future<void> _sendEmailVerificationLink() async {
  //   final response = await _signupRepository.sendEmailVerificationCode();
  //   response.fold((error) {
  //     _snackBarCubit.showSnackBar(error.message ?? 'Error');
  //   }, (success) {
  //     final currentContext = Navigation.router.routerDelegate.navigatorKey.currentContext;
  //     if (currentContext != null) currentContext.pushNamed(NavigationPath.signupVerificationRouteUri);
  //   });
  // }

  String? validateEmailAddress(String? val) => validateEmail(val);

  void onChangePassword(String value) {
    final passwordValidationState = PasswordValidationState(
      hasMinLength: value.length >= 6,
      hasUpperCase: value.contains(RegExp(r'[A-Z]')),
      hasLowerCase: value.contains(RegExp(r'[a-z]')),
      hasNumber: value.contains(RegExp(r'[0-9]')),
    );
    emit(state.copyWith(
        passwordState: passwordValidationState,
        isPasswordValidated: isPasswordValidated(passwordValidationState),
        authFailureOrSuccessOption: none()));
  }

  bool isPasswordValidated(PasswordValidationState passwordState) {
    return passwordState.hasNumber && passwordState.hasMinLength && passwordState.hasUpperCase && passwordState.hasLowerCase;
  }

  String? validatePassword(String? val) {
    final password = state.passwordValidationState;
    if (val == null || val.isEmpty) {
      return localizations.please_setup_a_password;
    }
    if (!(password?.hasMinLength ?? true) ||
        !(password?.hasUpperCase ?? true) ||
        !(password?.hasLowerCase ?? true) ||
        !(password?.hasNumber ?? true)) {
      return localizations.please_try_again_with_a_password;
    }
    return null;
  }

  void obscurePassword() => emit(state.copyWith(isPasswordObscure: !state.isPasswordObscure, authFailureOrSuccessOption: none()));

  void changeAgreement() => emit(state.copyWith(isTermsAgreed: !(state.isTermsAgreed ?? false), authFailureOrSuccessOption: none()));

  void launchPrivacyOrTerms(bool isPrivacy) {
    const privacyUrl = 'https://igmuapp.com/cookies-privacy-policy/';
    const termsUrl = 'https://igmuapp.com/terms-and-conditions/';
    GetIt.instance<NavigationService>().launchUrl(urlString: isPrivacy ? privacyUrl : termsUrl, external: true);
  }


  @override
  Future<void> close() {
    _signupStreamSubscription.cancel();
    return super.close();
  }
}
