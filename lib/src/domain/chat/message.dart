import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable(explicitToJson: true)
@HiveType(typeId: 2)
class Message extends HiveObject {
  Message({
    required this.receiverId,
    required this.senderId,
    required this.senderName,
    required this.senderAvatar,
    required this.text,
    required this.timestamp,
    required this.isLink,
    required this.isRead,
  });

  factory Message.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    // Handle timestamp with null safety
    final timestamp = data['timestamp'] as Timestamp?;
    if (timestamp == null) {
      debugPrint('⚠️ Missing timestamp in message ${doc.id}');
    }

    return Message(
      receiverId: (data['receiverId'] as String?) ?? '',
      senderId: (data['senderId'] as String?) ?? 'unknown_sender',
      senderName: (data['senderName'] as String?) ?? 'Unknown',
      senderAvatar: (data['senderAvatar'] as String?) ?? '',
      text: (data['text'] as String?) ?? '',
      timestamp:
          timestamp?.millisecondsSinceEpoch ?? 0, // Fallback to 0 if null
      isLink: (data['isLink'] as bool?) ?? false,
      isRead: (data['isRead'] as bool?) ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'receiverId': receiverId,
      'senderId': senderId,
      'senderName': senderName,
      'senderAvatar': senderAvatar,
      'text': text,
      'timestamp': timestamp,
      'isLink': isLink,
      'isRead': isRead,
    };
  }

  @HiveField(0)
  final String receiverId;

  @HiveField(1)
  final String senderId;

  @HiveField(2)
  final String senderName;

  @HiveField(3)
  final String senderAvatar;

  @HiveField(4)
  final String text;

  @HiveField(5)
  final int timestamp;

  @HiveField(6)
  final bool isLink;

  @HiveField(7)
  final bool isRead;

  Message copyWith({
    String? text,
    String? senderAvatar,
    bool? isLink,
    bool? isRead,
  }) {
    return Message(
      receiverId: receiverId,
      senderId: senderId,
      senderName: senderName,
      senderAvatar: senderAvatar ?? this.senderAvatar,
      text: text ?? this.text,
      timestamp: timestamp,
      isLink: isLink ?? this.isLink,
      isRead: isRead ?? this.isRead,
    );
  }
}
