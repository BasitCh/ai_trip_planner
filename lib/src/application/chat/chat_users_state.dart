part of 'chat_users_cubit.dart';

abstract class ChatUsersState extends Equatable {
  @override
  List<Object> get props => [];
}

class ChatUsersInitial extends ChatUsersState {}

class ChatUsersLoading extends ChatUsersState {}

class ChatUsersLoaded extends ChatUsersState {
  final List<Map<String, dynamic>> users;

  ChatUsersLoaded({required this.users});

  @override
  List<Object> get props => [users];
}

class ChatUsersError extends ChatUsersState {
  final String errorMessage;

  ChatUsersError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
