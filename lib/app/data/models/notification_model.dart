import 'dart:ui';

class NotificationModel {
  final String userName;
  final String userInitials;
  final Color avatarColor;
  final String time;
  final String action;
  final String subject;
  final bool isUnread;

  NotificationModel({
    required this.userName,
    required this.userInitials,
    required this.avatarColor,
    required this.time,
    required this.action,
    required this.subject,
    this.isUnread = false,
  });
}