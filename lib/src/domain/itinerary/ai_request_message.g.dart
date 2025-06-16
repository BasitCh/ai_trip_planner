// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_request_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AiRequestMessage _$AiRequestMessageFromJson(Map<String, dynamic> json) =>
    AiRequestMessage(
      role: json['role'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$AiRequestMessageToJson(AiRequestMessage instance) =>
    <String, dynamic>{
      'role': instance.role,
      'content': instance.content,
    };
