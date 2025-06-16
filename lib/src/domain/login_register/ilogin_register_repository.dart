import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:travel_hero/src/domain/login_register/login_register_request.dart';
import 'package:widgets_book/widgets_book.dart';

abstract class ILoginRegisterRepository{
  Future<Either<ApiError, User?>> signUpWithEmail(LoginRegisterRequest loginRegisterRequest);
}