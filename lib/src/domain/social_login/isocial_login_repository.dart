import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:widgets_book/widgets_book.dart';

abstract class ISocialLoginRepository{
  Future<Either<ApiError, User?>> loginWithGoogle();
  Future<Either<ApiError, User?>> loginWithApple();
  Future<Either<ApiError, User?>> loginWithFaceBook();
}