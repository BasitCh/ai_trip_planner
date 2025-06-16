import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:travel_hero/global/global.dart';
import 'package:travel_hero/global/notification/notification_handler.dart';
import '../notification/notification_handler_impl.dart';
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await FirebaseMessagingService._instance?.setupFlutterNotifications();
  FirebaseMessagingService._instance?.showFlutterNotification(message);
}

class FirebaseMessagingService {
  FirebaseMessagingService._internal() {
    _initializeChannel();
  }

  static FirebaseMessagingService? _instance;
  static final NotificationHandler _notificationHandler = NotificationHandlerImpl();
  late AndroidNotificationChannel channel;
  bool isFlutterLocalNotificationsInitialized = false;

  factory FirebaseMessagingService() {
    _instance ??= FirebaseMessagingService._internal();
    return _instance!;
  }

  void _initializeChannel() {
    channel = const AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );
  }

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await _requestPermission();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (isChatScreenOpen) {
        return;
      }
      showFlutterNotification(message);
    });
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      _notificationHandler.handleNotificationClick(message?.data);
      _localNotificationsPlugin.cancelAll();
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _notificationHandler.handleNotificationClick(message.data);
      _localNotificationsPlugin.cancelAll();
    });
  }

  Future<void> setupFlutterNotifications() async {
    if (isFlutterLocalNotificationsInitialized) {
      return;
    }
    await _localNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    isFlutterLocalNotificationsInitialized = true;
  }

  void showFlutterNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null && !kIsWeb) {
      _localNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: '@drawable/ic_notification',
          ),
        ),
        payload: _notificationHandler.createPayloadJson(message.data),
      );
      _localNotificationsPlugin.initialize(
        const InitializationSettings(
          android: AndroidInitializationSettings('@drawable/ic_notification'),
        ),
        onDidReceiveNotificationResponse: (NotificationResponse response) {
          _notificationHandler.handleNotificationClick(_notificationHandler.getPayloadJson(response));
          _localNotificationsPlugin.cancelAll();
        },
      );
    }
  }

  Future<void> _requestPermission() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('✅ Notification permission granted.');
    } else {
      log('❌ Notification permission declined.');
    }
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}