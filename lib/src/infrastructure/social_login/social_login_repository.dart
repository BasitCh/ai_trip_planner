import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:travel_hero/src/domain/social_login/isocial_login_repository.dart';
import 'package:widgets_book/widgets_book.dart';

class SocialLoginRepository extends ISocialLoginRepository {
  SocialLoginRepository(
      this._firebaseAuth, this._googleSignIn,this._facebookAuth);

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FacebookAuth _facebookAuth;
  @override
  Future<Either<ApiError, User?>> loginWithGoogle() async {
    try {
      await _googleSignIn.signOut();
      final googleUser = await _googleSignIn.signIn().catchError((err) {
        throw Exception(err);
      });

      if (googleUser == null) {
        return left(ApiError(message: 'Cancelled by user'));
      }

      final googleAuth = await googleUser.authentication;

      final authCredential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      return _firebaseAuth
          .signInWithCredential(authCredential)
          .then<Either<ApiError, User?>>((userCredential) {
        return right<ApiError, User?>(userCredential.user);
      }).catchError((error) {
        if (error is SocketException) {
          return left<ApiError, User?>(
              ApiError(message: 'Make sure you are connected to the internet'));
        } else {
          log(error.toString());
          final message = error.toString();
          if (message.toLowerCase().contains('network error')) {
            return left<ApiError, User?>(ApiError(
                message: 'Make sure you are connected to the internet'));
          }
          return left<ApiError, User?>(ApiError(message: error.toString()));
        }
      });
    } catch (e) {
      log(e.toString());
      return left(ApiError(message: e.toString()));
    }
  }

  @override
  Future<Either<ApiError, User?>> loginWithApple() async {
    try {
      final appleUser = await SignInWithApple.getAppleIDCredential(
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: 'com.yourcompany.yourapp', // Your Service ID from Apple Developer Console
          redirectUri: Uri.parse('https://travel-hero---dev.firebaseapp.com/__/auth/handler'),
        ),
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      ).catchError((err) {
        throw Exception(err);
      });
      final authCredential = AppleAuthProvider.credential(
          appleUser.identityToken.toString()
      );

      return _firebaseAuth
          .signInWithCredential(authCredential)
          .then<Either<ApiError, User?>>((userCredential) {
        return right<ApiError, User?>(userCredential.user);
      }).catchError((error) {
        if (error is SocketException) {
          return left<ApiError, User?>(
              ApiError(message: 'Make sure you are connected to the internet'));
        } else {
          log(error.toString());
          final message = error.toString();
          if (message.toLowerCase().contains('network error')) {
            return left<ApiError, User?>(ApiError(
                message: 'Make sure you are connected to the internet'));
          }
          return left<ApiError, User?>(ApiError(message: error.toString()));
        }
      });
    } catch (e) {
      log(e.toString());
      return left(ApiError(message: e.toString()));
    }
  }
  @override
  Future<Either<ApiError, User?>> loginWithFaceBook() async {
    try {
      final faceBookUser = await _facebookAuth.login().catchError((err) {
        throw Exception(err);
      });
      final authCredential = FacebookAuthProvider.credential(faceBookUser.accessToken!.tokenString);

      return _firebaseAuth
          .signInWithCredential(authCredential)
          .then<Either<ApiError, User?>>((userCredential) {
        return right<ApiError, User?>(userCredential.user);
      }).catchError((error) {
        if (error is SocketException) {
          return left<ApiError, User?>(
              ApiError(message: 'Make sure you are connected to the internet'));
        } else {
          log(error.toString());
          final message = error.toString();
          if (message.toLowerCase().contains('network error')) {
            return left<ApiError, User?>(ApiError(
                message: 'Make sure you are connected to the internet'));
          }
          return left<ApiError, User?>(ApiError(message: error.toString()));
        }
      });
    } catch (e) {
      log(e.toString());
      return left(ApiError(message: e.toString()));
    }
  }
}
