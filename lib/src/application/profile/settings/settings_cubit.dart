
import 'package:flutter/material.dart';
import 'package:travel_hero/global/navigation.dart';
import 'package:travel_hero/src/application/login_register/app_user_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_hero/src/application/profile/settings/settings_state.dart';
import 'package:travel_hero/src/application/profile/update_profile_cubit.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsState(
    isPublicProfile: Navigation.router.routerDelegate.navigatorKey.currentContext!.read<AppUserCubit>().state?.isPublicProfile??false,
    emailsEnabled: Navigation.router.routerDelegate.navigatorKey.currentContext!.read<AppUserCubit>().state?.isEmail??false,
    notificationsEnabled: Navigation.router.routerDelegate.navigatorKey.currentContext!.read<AppUserCubit>().state?.isNotification??false,
    tripRate: Navigation.router.routerDelegate.navigatorKey.currentContext!.read<AppUserCubit>().state?.tripPlanRate??0.0,
  ));

  void togglePublicProfile(BuildContext context) {
    emit(state.copyWith(isPublicProfile: !state.isPublicProfile));
  }

  void toggleNotifications(BuildContext context) {
    emit(state.copyWith(notificationsEnabled: !state.notificationsEnabled));
  }

  void toggleEmails(BuildContext context) {
    emit(state.copyWith(emailsEnabled: !state.emailsEnabled));
  }
  void updateTripRate(BuildContext context,String value) {
    double? newRate = double.tryParse(value);
    if (newRate != null) {
      emit(state.copyWith(tripRate: newRate));
    }
  }
  void updateUserAndSave(BuildContext context){
    var updatedUser=context.read<AppUserCubit>().state!.copyWith(isPublicProfile: state.isPublicProfile,tripPlanRate: state.tripRate,isNotification: state.notificationsEnabled,isEmail: state.emailsEnabled);
    context.read<UpdateProfileCubit>().updateUserData(updatedUser);
  }
}