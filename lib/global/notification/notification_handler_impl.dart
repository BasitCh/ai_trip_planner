import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications_platform_interface/src/types.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_hero/global/global.dart';
import 'package:travel_hero/global/navigation.dart';
import 'package:travel_hero/src/infrastructure/routes/app_routes.dart';

import 'notification_handler.dart';

class NotificationHandlerImpl extends NotificationHandler {
  static final NotificationHandlerImpl _instance =
      NotificationHandlerImpl._internal();

  factory NotificationHandlerImpl() => _instance;

  NotificationHandlerImpl._internal();

  @override
  void handleNotificationClick(Map<String, dynamic>? response) {
    try {
      if (response != null) {
        if (response['type'] == "new_message" && !isChatScreenOpen) {
          Navigation.router.routerDelegate.navigatorKey.currentContext!
              .pushNamed(
            NavigationPath.chatRouteUri,
            pathParameters: {
              'chatRoomId': response['chatId'] ?? '',
              'receiverName': Uri.encodeComponent('asdasd'),
              'receiverAvatar': Uri.encodeComponent('aasd'),
              'receiverId': response['receiverId'] ?? '',
            },
          );
        } else if (response['type'] == "itinerary") {
          Navigator.pushNamed(
              Navigation.router.routerDelegate.navigatorKey.currentContext!,
              NavigationPath.chatRouteUri);
        }
      }
    }catch(e){
    }
  }

  @override
  String createPayloadJson(Map<String, dynamic> data) {
    try {
      // Create a Map to represent your object
      Map<String, dynamic> payloadData = {
        'type': data['type'],
        'chatId': data['chatId'],
        'senderId': data['senderId'],
        'receiverId': data['receiverId'],
      };
      // Serialize the Map to a JSON string
      String payloadJson = jsonEncode(data);
      return payloadJson;
    } catch (e) {
      // Handle any errors during serialization
      throw Exception('Failed to create payload JSON: $e');
    }
  }

  @override
  Map<String, dynamic> getPayloadJson(
      NotificationResponse notificationResponse) {
    return jsonDecode(notificationResponse.payload!);
  }
}
