import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_hero/global/global.dart';
import 'package:travel_hero/src/application/chat/unread_message_count_cubit.dart';
import 'package:travel_hero/src/domain/chat/message.dart';
import 'package:travel_hero/src/infrastructure/chat/message_repository.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' show PreviewData;
import 'package:flutter_link_previewer/flutter_link_previewer.dart';
part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  final MessageRepository messageRepository;
  final TextEditingController messageController = TextEditingController();
  final String chatRoomId;
  StreamSubscription<List<Message>>? _messageSubscription;
  final String receiverId;
  Map<String, PreviewData> previewDataCache = {};
  final BuildContext context;

  MessageCubit({
    required this.messageRepository,
    required this.chatRoomId,
    required this.receiverId,
    required this.context,
  }) : super(MessageInitial()) {
    isChatScreenOpen = true;
    loadMessages(context);
  }

  /// Load messages for a specific user chat
  void loadMessages(BuildContext context) {
    emit(MessageLoading());
    try {
      _messageSubscription?.cancel();
      _messageSubscription = messageRepository
          .getMessages(chatRoomId: chatRoomId)
          .listen((messages) async {
        final tempPreviewDataCache = <String, PreviewData>{};
        
        // Pre-fetch previews for new URLs
        for (final message in messages) {
          final url = extractUrl(message.text);
          if (url != null && !previewDataCache.containsKey(url)) {
            try {
              final previewData = await getPreviewData(url);
              tempPreviewDataCache[url] = previewData;
            } catch (e) {
              if (kDebugMode) {
                print("Error fetching preview data: $e");
              }
            }
          }
        }
        previewDataCache.addAll(tempPreviewDataCache);
        messageRepository.markMessagesAsRead(chatRoomId: chatRoomId);
        context.read<UnreadMessageCountCubit>().loadUnreadMessage(); // Refresh unread count
        emit(MessageLoaded(
          messages: messages,
          previewData: Map.from(previewDataCache),
        ));
      });
    } catch (e) {
      emit(MessageError(errorMessage: e.toString()));
    }
  }

  /// Handle text input changes and link previews
  void onTextChanged() {
    final text = messageController.text;
    fetchPreviewData(text);
    
    if (state is MessageLoaded) {
      final currentState = state as MessageLoaded;
      emit(currentState.copyWith(
        draftText: text,
        previewData: previewDataCache,
      ));
    } else {
      emit(MessageLoaded(
        messages: const [],
        previewData: previewDataCache,
        draftText: text,
      ));
    }
  }

  /// Fetch link preview data
  void fetchPreviewData(String text) async {
    final url = extractUrl(text);
    if (url != null && !previewDataCache.containsKey(url)) {
      try {
        final previewData = await getPreviewData(url);
        previewDataCache[url] = previewData;
        _updateStateWithPreview();
      } catch (e) {
        if (kDebugMode) {
          print("Error fetching preview data: $e");
        }
      }
    }
  }

  void _updateStateWithPreview() {
    if (state is MessageLoaded) {
      final currentState = state as MessageLoaded;
      emit(currentState.copyWith(
        previewData: Map.from(previewDataCache),
      ));
    }
  }



  void sendMessage() {
    if (messageController.text.trim().isEmpty) return;

    messageRepository.sendMessage(
      chatRoomId: chatRoomId,
      receiverId: receiverId,
      text: messageController.text.trim(),
    );
    messageController.clear();
    _clearPreviewData();
  }

  void _clearPreviewData() {
    previewDataCache.clear();
    if (state is MessageLoaded) {
      final currentState = state as MessageLoaded;
      emit(currentState.copyWith(
        previewData: {},
        draftText: '',
      ));
    }
  }

  void markAllAsRead() {
    messageRepository.markMessagesAsRead(chatRoomId: chatRoomId);
  }

  void toggleEmojiPicker() {
    if (state is MessageLoaded) {
      final currentState = state as MessageLoaded;
      emit(currentState.copyWith(
        isEmojiPickerVisible: !currentState.isEmojiPickerVisible,
      ));
    }
  }
  @override
  Future<void> close() {
    _messageSubscription?.cancel(); // Cancel stream subscription on dispose
    isChatScreenOpen = false;
    return super.close();
  }
  /// Extract first URL from text
  String? extractUrl(String text) {
    final urlRegex = RegExp(
      r"(https?:\/\/[^\s]+)",
      caseSensitive: false,
      multiLine: true,
    );
    return urlRegex.firstMatch(text)?.group(0);
  }
}