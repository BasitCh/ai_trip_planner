import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_hero/global/navigation.dart';
import 'package:travel_hero/repositories/user_repository.dart';
import 'package:travel_hero/src/application/login_register/app_user_cubit.dart';
import 'package:travel_hero/src/application/profile/widgets/alert_dilog_box.dart';
import 'package:travel_hero/src/domain/login_register/app_user.dart';
import 'package:travel_hero/src/infrastructure/routes/app_routes.dart';
import 'package:widgets_book/widgets_book.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  final UserRepository _userRepository;

  UpdateProfileCubit(this._userRepository) : super(const UpdateProfileState());

  // Future<void> updateUserName(String userName) async {
  //   emit(state.copyWith(isSubmitting: true, authFailureOrSuccessOption: none()));
  //   final response = await _userRepository.updateUserName(userName);
  //   emit(state.copyWith(
  //     authFailureOrSuccessOption: optionOf(response),
  //     isSubmitting: false,
  //     userName: userName,
  //   ));
  // }

  void updateCoverPicture(File coverPictureUrl) async {

    emit(state.copyWith(isSubmitting: true));
    final response = await _userRepository.updateUserCoverPhoto(coverPictureUrl);

    response.fold((a) {

    }, (profileUpdate) async {
      Navigation.router.routerDelegate.navigatorKey.currentContext!.read<
          AppUserCubit>().setUser(profileUpdate);
      // await profileUpdate.fold((error) {
      //   final errorMessage = error.message;
      //   if (errorMessage != null) {
      //     // Show SnackBar or any other UI message
      //   }
      // }, (user) async {
      //
      //   Navigation.router.routerDelegate.navigatorKey.currentContext!.read<AppUserCubit>().setUser(user);
      // }
    });
    emit(state.copyWith(
      isSubmitting: false,
      coverPictureUrl: coverPictureUrl.path,
    ));
  }

  void updateUserData(AppUser appUser) async {
    emit(state.copyWith(isSubmitting: true));
    final response = await _userRepository.updateUser(appUser);

    response.fold((a) {

    }, (profileUpdate) async {
      Navigation.router.routerDelegate.navigatorKey.currentContext!.read<
          AppUserCubit>().setUser(profileUpdate);
    });
    emit(state.copyWith(
      isSubmitting: false,
    ));
  }

  Future<void> deleteCoverPhoto() async {
    emit(state.copyWith(isSubmitting: true));

    final response = await _userRepository.deleteUserCoverPhoto(); // New repository call
    response.fold(
          (failure) {
        // Handle error
      },
          (profileUpdate) {
            Navigation.router.routerDelegate.navigatorKey.currentContext!.read<
                AppUserCubit>().setUser(profileUpdate);
        //     print("profileUpdate ${profileUpdate.coverPhotoUrl}");
        // Navigation.router.routerDelegate.navigatorKey.currentContext!
        //     .read<AppUserCubit>()
        //     .setUser(profileUpdate);
      },
    );

    emit(state.copyWith(
      isSubmitting: false,
      coverPictureUrl: null,
    ));
  }

  // Future<void> updateUserProfile({String? userName, String? pictureUrl}) async {
  //   emit(state.copyWith(isSubmitting: true, authFailureOrSuccessOption: none()));
  //   final response = await _userRepository.updateUserProfile(userName, pictureUrl);
  //   emit(state.copyWith(
  //     authFailureOrSuccessOption: optionOf(response),
  //     isSubmitting: false,
  //   ));
  // }
  Future<void> onLogout() async {
    final context = Navigation.router.routerDelegate.navigatorKey.currentContext;
    if (context == null) return;
    final  widget = DeleteConfirmationDialog(
      title: 'Logout',
      content: 'Are you sure you want to logout ?',
      deleteText: 'Logout',
      insetPadding: EdgeInsets.all(34.h),
    );

    final confirmLogout = await showDialog<bool>(context: context, builder: (context) => widget);
    if(confirmLogout == null || !confirmLogout) return;
    await FirebaseAuth.instance.signOut();
    _userRepository.clearUserData();
    context.goNamed(NavigationPath.loginRouteUri);
  }
  void onProfileUpdateStateUpdated() {
    state.authFailureOrSuccessOption.fold(() {}, (profileUpdate) async {
      await profileUpdate.fold((error) {
        final errorMessage = error.message;
        if (errorMessage != null) {
          // Show SnackBar or any other UI message
        }
      }, (user) async {

        Navigation.router.routerDelegate.navigatorKey.currentContext!.read<AppUserCubit>().setUser(user);
      });
    });
  }
}