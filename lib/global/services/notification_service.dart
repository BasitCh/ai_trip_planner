import 'package:flutter/material.dart';
import 'package:travel_hero/widgets/notification_card.dart';
import 'package:widgets_book/widgets_book.dart';

class NotificationService {
  static void showCustomNotification(
      BuildContext context, String message, String time) {
    final overlay = scaffoldMessengerGlobalKey.currentContext?.findAncestorStateOfType<OverlayState>();
    if (overlay == null) return;

    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 16,
        left: 0,
        right: 0,
        child: NotificationCard(
          profileImage: 'https://via.placeholder.com/150',
          message: message,
          time: time,
          onViewNow: () {
            //overlayEntry.remove();
          },
          onLater: () {
            //overlayEntry.remove();
          },
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 5), () {
      overlayEntry.remove();
    });
  }
}