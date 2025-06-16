// Abstract class for handling notification actions
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
abstract class NotificationHandler {
  void handleNotificationClick(Map<String, dynamic>? notificationType);
  String createPayloadJson(Map<String, dynamic> data);
  // Deserialize the JSON string back to a Map
  Map<String, dynamic> getPayloadJson(NotificationResponse notificationResponse);
}