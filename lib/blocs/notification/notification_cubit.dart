// Notification Cubit
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part  'notification_state.dart';
class NotificationCubit extends Cubit<NotificationState> {

  NotificationCubit() : super(const NotificationState()) {
    _listenForNotifications();
  }

  void _listenForNotifications() {
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //     print("message::${message.messageId}");
    //   emit(state.copyWith(
    //     message: message.notification?.body ?? "Your trip plan is ready!",
    //     hasNotification: true,
    //   ));
    // });
  }

  void clearNotification() {
    emit(state.copyWith(message: "", hasNotification: false));
  }
}