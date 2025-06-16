import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginRegisterResponse extends Equatable {
  const LoginRegisterResponse({required this.user});

  final User? user;

  @override
  List<Object?> get props => [user];
}
