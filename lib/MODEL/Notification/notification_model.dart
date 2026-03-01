import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';

class NotificationsModel {
  final int id;
  final String title;
  final String body;
  final String time;
  final NotificationType type;
  final bool isRead;

  NotificationsModel({
    required this.id,
    required this.title,
    required this.body,
    required this.time,
    this.type = NotificationType.pending,
    this.isRead = false,
  });

  factory NotificationsModel.fromJson(Map<String, dynamic> json) {
    return NotificationsModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      time: json['created_at'],
      type: NotificationType.pending,
    );
  }
}
