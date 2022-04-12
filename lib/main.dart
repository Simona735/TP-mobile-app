import 'dart:developer';
import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:tp_mobile_app/firebase/authentication.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tp_mobile_app/firebase/database.dart';
import 'package:tp_mobile_app/screens/manager.dart';
import 'widgets/notifications.dart';
import 'dart:developer' as developer;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Authentication.init();

  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);

  FirebaseMessaging.onBackgroundMessage(Notifications.pushMessage);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    Notifications.basicNotification(message.notification!.title ?? "Error",
        message.notification!.body ?? "Error",  Random().nextInt(2147483647));
  });

  AwesomeNotifications().initialize(
    'resource://drawable/icon_notify',
    [
      NotificationChannel(
        channelKey: 'key1',
        channelName: 'Mailbox app',
        channelDescription: 'Test',
        defaultColor: const Color(0xff9050dd),
        enableLights: true,
        enableVibration: true,
      ),
    ],
  );
  runApp(MainPage());
}
