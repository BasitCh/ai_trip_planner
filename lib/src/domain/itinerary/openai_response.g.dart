// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'openai_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpenAIResponse _$OpenAIResponseFromJson(Map<String, dynamic> json) =>
    OpenAIResponse(
      choices: (json['choices'] as List<dynamic>)
          .map((e) => Choice.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OpenAIResponseToJson(OpenAIResponse instance) =>
    <String, dynamic>{
      'choices': instance.choices.map((e) => e.toJson()).toList(),
    };

Choice _$ChoiceFromJson(Map<String, dynamic> json) => Choice(
      message: Message.fromJson(json['message'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChoiceToJson(Choice instance) => <String, dynamic>{
      'message': instance.message,
    };

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      content: json['content'] as String,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'content': instance.content,
    };
