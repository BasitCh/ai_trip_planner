import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_hero/src/infrastructure/chat/message_repository.dart';

class UnreadMessageCountCubit extends Cubit<int> {
  final MessageRepository messageRepository;

  UnreadMessageCountCubit(this.messageRepository) : super(0);

  void loadUnreadMessage() async {
    messageRepository.getUnreadMessagesCount().listen((count) async {
      emit(count);
    });
  }
}