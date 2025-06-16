import 'package:json_annotation/json_annotation.dart';

part 'openai_response.g.dart'; // Run build_runner to generate this file

@JsonSerializable(explicitToJson: true)
class OpenAIResponse {
  final List<Choice> choices;

  OpenAIResponse({required this.choices});

  factory OpenAIResponse.fromJson(Map<String, dynamic> json) =>
      _$OpenAIResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OpenAIResponseToJson(this);
}

@JsonSerializable()
class Choice {
  final Message message;

  Choice({required this.message});

  factory Choice.fromJson(Map<String, dynamic> json) =>
      _$ChoiceFromJson(json);

  Map<String, dynamic> toJson() => _$ChoiceToJson(this);
}

@JsonSerializable()
class Message {
  final String content;

  Message({required this.content});

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
