import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travel_hero/src/infrastructure/chat/message_repository.dart';

part 'chat_users_state.dart';

class ChatUsersCubit extends Cubit<ChatUsersState> {
  final MessageRepository messageRepository;
  StreamSubscription<List<Map<String, dynamic>>>? _userChatStreamSubscription;
  ChatUsersCubit({required this.messageRepository,})
      : super(ChatUsersInitial()) {
    loadChatUsers();
  }

  void loadChatUsers() {
    emit(ChatUsersLoading());
    _userChatStreamSubscription?.cancel();
    _userChatStreamSubscription = messageRepository.getChatRoomsStream().listen((chatRooms) async {
       messageRepository.getUnreadMessagesCount();
      emit(ChatUsersLoaded(users: chatRooms));
    });
  }
  @override
  Future<void> close() {
    _userChatStreamSubscription?.cancel();
    return super.close();
  }
}
