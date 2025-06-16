part of 'notification_cubit.dart';
// Notification State
class NotificationState extends Equatable {
  final String message;
  final String profileImage;
  final String time;
  final bool hasNotification;

  const NotificationState({
    this.message = "",
    this.profileImage = "https://randomuser.me/api/portraits/men/1.jpg",
    this.time = "1m",
    this.hasNotification = false,
  });

  NotificationState copyWith({
    String? message,
    String? profileImage,
    String? time,
    bool? hasNotification,
  }) {
    return NotificationState(
      message: message ?? this.message,
      profileImage: profileImage ?? this.profileImage,
      time: time ?? this.time,
      hasNotification: hasNotification ?? this.hasNotification,
    );
  }

  @override
  List<Object?> get props => [message, profileImage, time, hasNotification];
}