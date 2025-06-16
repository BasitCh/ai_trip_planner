import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:travel_hero/src/domain/login_register/ilogin_register_repository.dart';
import 'package:travel_hero/src/domain/login_register/login_register_request.dart';
import 'package:widgets_book/widgets_book.dart';

class LoginRegisterRepository extends ILoginRegisterRepository {
  LoginRegisterRepository(this._firebaseAuth);

  final FirebaseAuth _firebaseAuth;

  @override
  Future<Either<ApiError, User>> loginUser(LoginRegisterRequest loginRegisterRequest) async {
    try {
      final response = await _firebaseAuth.signInWithEmailAndPassword(email: loginRegisterRequest.email, password: loginRegisterRequest.password);
      final user = response.user;
      if (user != null) {
        return right(user);
      } else {
        return left(ApiError(message: 'Failed to get user'));
      }
    } on FirebaseAuthException catch (e) {
    //   wrong-password: Thrown if the password is invalid for the given email, or the account corresponding to the email doesn't have a password set.
    // invalid-email: Thrown if the email address is not valid.
    // user-disabled: Thrown if the user corresponding to the given email has been disabled.
    // user-not-found:
      if(e.code == 'wrong-password'){
        return left(ApiError(message: 'Invalid password'));
      }
      if(e.code == 'invalid-email'){
        return left(ApiError(message: 'Invalid email'));
      }
      if(e.code == 'user-disabled'){
        return left(ApiError(message: 'User disabled'));
      }
      if(e.code == 'user-not-found'){
        return left(ApiError(message: 'User not found'));
      }
      if(e.code == 'invalid-credential'){
        return left(ApiError(message: 'The email or password is incorrect'));
      }
      return left(ApiError(message: e.message));
    } catch (e) {
      return left(ApiError(message: e.toString()));
    }
  }

  @override
  Future<Either<ApiError, Unit>> sendPasswordResetEmailLink(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email).catchError((error) {
        throw Exception(error.toString());
      });
      return right(unit);
    } on FirebaseException catch (e) {
      return left(ApiError(message: e.message));
    } catch (e) {
      return left(ApiError(message: e.toString()));
    }
  }

  @override
  Future<Either<ApiError, User?>> signUpWithEmail(LoginRegisterRequest loginRegisterRequest) async {
    try {
      final response = await _firebaseAuth
          .createUserWithEmailAndPassword(
        email: loginRegisterRequest.email,
        password: loginRegisterRequest.password,
      );
      return right(response.user);
    } catch (e) {
      // Handle errors here
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'email-already-in-use':
          // Handle the case where the email is already in use
            return left(ApiError(message: 'An account with this email address already exists. Try logging in instead.'));
          case 'invalid-email':
          // Handle the case where the email is invalid
            return left(ApiError(message: 'The email address is not valid.'));
            break;
          case 'operation-not-allowed':
          // Handle the case where the operation is not allowed
            return left(ApiError(message: 'Operation not allowed.'));
            break;
          case 'weak-password':
          // Handle the case where the password is weak
            return left(ApiError(message: 'The password provided is too weak.'));
            break;
          default:
          // Handle any other errors
            return left(ApiError(message: e.message));
        }
      } else {
        // Handle any other exceptions
        return left(ApiError(message: e.toString()));
      }
    }
  }
}
