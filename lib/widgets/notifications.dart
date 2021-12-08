import 'dart:developer';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Notifications {
  static SnackBar snackBar(IconData icon, String text) {
    return SnackBar(
      content: SizedBox(
        height: 40,
        child: Row(
          children: [
            Icon(icon),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(text),
            ),
          ],
        ),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: const Color.fromRGBO(33, 150, 243, 0.5),
      elevation: 0.1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  static void basicNotification(String title, String body, int id,
      {String key = 'key1'}) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: id, channelKey: key, title: title, body: body),
    );
  }

  static pictureNotification(String title, String body, String picture, int id,
      {String key = 'key1'}) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: id,
          channelKey: key,
          title: title,
          body: body,
          bigPicture: picture,
          notificationLayout: NotificationLayout.BigPicture),
    );
  }

  static showToastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.blue,
        textColor: Colors.black38,
        fontSize: 16.0);
  }

  static Future<void> pushMessage(RemoteMessage message) async {
    log(message.data.toString());
    AwesomeNotifications().createNotificationFromJsonData(message.data);
  }
}
