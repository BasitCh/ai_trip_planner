import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_hero/src/domain/login_register/app_user.dart';

class AppUserCubit extends Cubit<AppUser?> {
  AppUserCubit() : super(null);

  // Set AppUser data
  void setUser(AppUser appUser) {
    emit(appUser);
  }
  // Clear the user data (e.g., logout)
  void clearUser() {
    emit(null);
  }
  void deletePhoto() {
    state!.copyWith(coverPhotoUrl: null);
    emit(state);
  }
}