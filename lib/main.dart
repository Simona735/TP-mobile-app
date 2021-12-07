import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:tp_mobile_app/firebase/authentication.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tp_mobile_app/screens/manager.dart';
import 'widgets/notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Authentication.init();

  FirebaseMessaging.onBackgroundMessage(Notifications.pushMessage);

  AwesomeNotifications().initialize(
    null,
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
