import 'package:equatable/equatable.dart';

class LoginRegisterRequest extends Equatable {
  const LoginRegisterRequest({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}
