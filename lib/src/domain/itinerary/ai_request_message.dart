import 'package:widgets_book/widgets_book.dart';

part 'ai_request_message.g.dart';

@JsonSerializable()
class AiRequestMessage {
  final String role; // "system" or "user"
  final String content;

  AiRequestMessage({
    required this.role,
    required this.content,
  });

  factory AiRequestMessage.fromJson(Map<String, dynamic> json) =>
      _$AiRequestMessageFromJson(json);

  Map<String, dynamic> toJson() => _$AiRequestMessageToJson(this);
}
