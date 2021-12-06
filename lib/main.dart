import 'package:flutter/material.dart';
import 'package:tp_mobile_app/firebase/authentication.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tp_mobile_app/firebase/database.dart';
import 'package:tp_mobile_app/screens/manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Authentication.init();
  Database.getDataService('user_id', 'mailbox_id');
  runApp(MainPage());
}

