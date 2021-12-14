import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationService {
  Future<void> Notify(msg) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: "key",
        title: "Alemeno_Sarthak",
        body: msg,
      ),
    );
  }
}
