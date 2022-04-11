import 'package:auto_route/auto_route.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tp_mobile_app/bindings/bottom_bar_binding.dart';
import 'package:tp_mobile_app/controllers/bottom_bar_controller.dart';
import 'package:tp_mobile_app/firebase/authentication.dart';
import 'package:tp_mobile_app/routes/router.gr.dart';
import 'package:tp_mobile_app/screens/authscreens/loginpage.dart';
import 'dart:developer' as developer;

import 'package:tp_mobile_app/screens/pin/pinpage.dart';
import 'package:tp_mobile_app/widgets/bottombar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final EncryptedSharedPreferences encryptedSharedPreferences =
      EncryptedSharedPreferences();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? value = prefs.getString('pin');
      bool valueDark = prefs.getBool('darkTheme') ?? false;
      if (valueDark) {
        Get.changeThemeMode(ThemeMode.dark);
      } else {
        Get.changeThemeMode(ThemeMode.light);
      }

      if (value != null) {
        developer.log(value);
        if (Authentication.isSignedIn && value.isNotEmpty) {
          Get.offAll(() => const PinPage());
        } else if (Authentication.isSignedIn && value.isEmpty) {
          Get.offAll(() => const BottomBar(), binding: BottomBarBinding());
        } else {
          Get.offAll(() => LoginPage());
        }
      } else {
        if (Authentication.isSignedIn) {
          Get.offAll(() => const BottomBar(), binding: BottomBarBinding());
        } else {
          Get.offAll(() => LoginPage());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      // child: FlutterLogo(size: MediaQuery.of(context).size.height),
    );
  }
}
