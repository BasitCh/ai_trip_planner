part of 'message_cubit.dart';

abstract class MessageState extends Equatable {
  const MessageState();

  @override
  List<Object> get props => [];
}

class MessageInitial extends MessageState {}

class MessageLoading extends MessageState {}

class MessageLoaded extends MessageState {
  final List<Message> messages;
  final Map<String, PreviewData> previewData;
  final bool isEmojiPickerVisible;
  final String draftText; // Add this property

  const MessageLoaded({
    required this.messages,
    required this.previewData,
    this.isEmojiPickerVisible = false,
    this.draftText = '', // Initialize with empty string
  });

  MessageLoaded copyWith({
    List<Message>? messages,
    Map<String, PreviewData>? previewData,
    bool? isEmojiPickerVisible,
    String? draftText,
  }) {
    return MessageLoaded(
      messages: messages ?? this.messages,
      previewData: previewData ?? this.previewData,
      isEmojiPickerVisible: isEmojiPickerVisible ?? this.isEmojiPickerVisible,
      draftText: draftText ?? this.draftText,
    );
  }

  @override
  List<Object> get props => [
        messages,
        previewData,
        isEmojiPickerVisible,
        draftText, // Add to props list
      ];
}

class MessageError extends MessageState {
  final String errorMessage;

  const MessageError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class MessageTyping extends MessageState {
  final String message;
  final Map<String, PreviewData> previewData;
  final List<Message> messages;
  final bool isEmojiPickerVisible; // Add emoji picker visibility state
  const MessageTyping( {this.isEmojiPickerVisible=false,required this.messages, required this.message, required this.previewData,});

  @override
  List<Object> get props => [message, previewData,messages,isEmojiPickerVisible];
}
