import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: implementation_imports
import 'package:fpdart/src/either.dart';
import 'package:travel_hero/global/internet.dart';
import 'package:travel_hero/global/navigation.dart';
import 'package:travel_hero/repositories/offline_extension/offline_supported_single_data_repository.dart';
import 'package:travel_hero/src/application/login_register/app_user_cubit.dart';
import 'package:travel_hero/src/domain/login_register/app_user.dart';
import 'package:travel_hero/src/infrastructure/utils/constants.dart';
import 'package:widgets_book/widgets_book.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserRepository extends OfflineSupportedSingleDataRepository<AppUser?> {
  UserRepository(this._firebaseAuth, this._firebaseFirestore) : super(HiveBoxes.users) {
    _firebaseAuth.authStateChanges().listen(_handleUserAuthObject);
  }

  bool shouldInitCollection = true;

  _handleUserAuthObject(User? user) async {
    if (user == null || shouldInitCollection == false) return;

    final userResult = await fetch();
    userResult.fold(
      (exception) {
        log('UserRepository: _handleUserAuthObject: $exception');
      },
      (userData) {
        updateData(userData);
        shouldInitCollection = false;
      },
    );
  }

  @override
  Future<Either<Exception, AppUser>> fetchFromApi() async {
    final userId = _firebaseAuth.currentUser?.uid;
    if (userId == null) return left(Exception('No user id'));
    return await _getUser(userId);
  }

  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  String getUserId() {
    return _firebaseAuth.currentUser?.uid ?? '';
  }

  Future<Either<Exception, AppUser>> _getUser(String userId) async {
    try {
      final connection = await Internet.hasInternetConnection();
      !connection ? throw Exception('No internet connection') : log('UserRepository: _getUser: Connected to internet');
      final response = await _firebaseFirestore.collection(FirestoreCollection.users).doc(userId).get();
      final userMap = response.data();
      if (userMap == null) return left(UserDataNotCreatedYet(userId, "doc returned empty response"));
      final user = AppUser.fromJson(userMap);
      return right(user);
    } on FirebaseException catch (e) {
      return left(Exception(e.message));
    } catch (e) {
      return left(Exception(e.toString()));
    }
  }

  Future<Either<ApiError, AppUser>> createUser(AppUser user) async {
    try {
      final uid = _firebaseAuth.currentUser?.uid;
      if (uid != null) {
        user.uid = uid;
        await _firebaseFirestore
            .collection(FirestoreCollection.users)
            .doc(uid)
            .set(user.toJson())
            .catchError((error) => print("Failed to add user: $error"));
      }
      updateData(user);
      return right(user);
    } on FirebaseException catch (e) {
      return left(ApiError(message: e.message));
    } catch (e) {
      return left(ApiError(message: e.toString()));
    }
  }
  Future<Either<ApiError, AppUser>> updateUserCoverPhoto(File coverPhotoPath) async {
    try {

        // Upload the cover photo to Firebase Storage
        final storageRef = FirebaseStorage.instance.ref().child('user_cover_photos/${_firebaseAuth.currentUser!.uid}');
        final uploadTask = await storageRef.putFile(coverPhotoPath);
        final coverPhotoUrl = await uploadTask.ref.getDownloadURL();
        final updatedUser =
        Navigation.router.routerDelegate.navigatorKey.currentContext!.read<
            AppUserCubit>().state!.copyWith(coverPhotoUrl: coverPhotoUrl);
        // Update Firestore with the new cover photo URL
        await FirebaseFirestore.instance
            .collection('users') // Firestore collection
            .doc(_firebaseAuth.currentUser!.uid)
            .set(updatedUser.toJson(), SetOptions(merge: true));

        return right(updatedUser);
    } on FirebaseException catch (e) {
      return left(ApiError(message: e.message ?? 'An unknown Firebase error occurred.'));
    } catch (e) {
      return left(ApiError(message: e.toString()));
    }
  }
  Future<Either<ApiError, AppUser>> updateUserData(AppUser appUser) async {
    try {
      // Update Firestore with the new cover photo URL
      await FirebaseFirestore.instance
          .collection('users') // Firestore collection
          .doc(_firebaseAuth.currentUser!.uid)
          .set(appUser.toJson(), SetOptions(merge: true));

      return right(appUser);
    } on FirebaseException catch (e) {
      return left(ApiError(message: e.message ?? 'An unknown Firebase error occurred.'));
    } catch (e) {
      return left(ApiError(message: e.toString()));
    }
  }

  Future<Either<ApiError, AppUser>> deleteUserCoverPhoto() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final userId = user?.uid;

      if (userId == null) {
        return left(ApiError(message: "User not found"));
      }

      // Reference to the cover photo in Firebase Storage
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('user_cover_photos/$userId');

      // Delete from Firebase Storage
      await storageRef.delete();
      final updatedUser =
      Navigation.router.routerDelegate.navigatorKey.currentContext!.read<
          AppUserCubit>().state!.copyWith(coverPhotoUrl: "");
      // Update Firestore with the new cover photo URL
      await FirebaseFirestore.instance
          .collection('users') // Firestore collection
          .doc(_firebaseAuth.currentUser!.uid)
          .set(updatedUser.toJson(), SetOptions(merge: true));
      // // Update Firestore field to remove cover photo URL
      // await FirebaseFirestore.instance
      //     .collection('users')
      //     .doc(userId)
      //     .update({'coverPhotoUrl': FieldValue.delete()});

      // Retrieve updated user state
      // final updatedUser = Navigation.router.routerDelegate.navigatorKey.currentContext!
      //     .read<AppUserCubit>()
      //     .state!
      //     .copyWith(coverPhotoUrl: null);
      // print("updatedUser.coverPhotoUrl ${updatedUser.coverPhotoUrl}");

      return right(updatedUser);
    } catch (e) {
      return left(ApiError(message: e.toString()));
    }
  }

  Future<Either<ApiError, AppUser>> updateUser(AppUser user) async {
    try {
      if (user.uid != null) {
        await _firebaseFirestore
            .collection(FirestoreCollection.users)
            .doc(user.uid)
            .set(user.toJson(), SetOptions(merge: true))
            .catchError((error) => print("Failed to add user: $error"));
        return right(user);
      } else {
        return left(ApiError(message: 'Unauthorized user.'));
      }
    } on FirebaseException catch (e) {
      return left(ApiError(message: e.message));
    } catch (e) {
      return left(ApiError(message: e.toString()));
    }
  }

  Future<Either<ApiError, AppUser>> updateUserDeviceToken(String token) async {
    try {
      final uid = _firebaseAuth.currentUser?.uid;
      if (uid == null) {
        return left(ApiError(message: "User not authenticated"));
      }

      // Prepare the data you want to update.
      // You can include additional fields, such as the device platform.
      final updateData = {
        'deviceToken': token,
        'devicePlatform': Platform.operatingSystem, // e.g. 'android' or 'ios'
        'updatedAt': DateTime.now().toIso8601String(), // optional timestamp
      };

      // Update the user's document in Firestore using merge to avoid overwriting other fields.
      await _firebaseFirestore
          .collection(FirestoreCollection.users)
          .doc(uid)
          .set(updateData, SetOptions(merge: true));

      // Optionally, fetch the updated user data to update the local state.
      final updatedUserResult = await _getUser(uid);
      return updatedUserResult.fold(
            (exception) => left(ApiError(message: exception.toString())),
            (user) => right(user),
      );
    } on FirebaseException catch (e) {
      return left(ApiError(message: e.message ?? 'An unknown Firebase error occurred.'));
    } catch (e) {
      return left(ApiError(message: e.toString()));
    }
  }

  Future<Either<ApiError, AppUser>> deleteUser(String userId) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  void clearUserData() {
    updateData(null);
  }
}

class UserDataNotCreatedYet extends Equatable implements Exception {
  final String userId;
  final String message;

  const UserDataNotCreatedYet(this.userId, this.message);

  @override
  List<Object?> get props => [userId, message];
}
