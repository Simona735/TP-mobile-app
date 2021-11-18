import 'package:auto_route/auto_route.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tp_mobile_app/firebase/authentication.dart';
import 'package:tp_mobile_app/routes/router.gr.dart';
import 'dart:developer' as developer;

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
      if (value != null) {
        developer.log(value);
        if (Authentication.isSignedIn && value.isNotEmpty) {
          Navigator.of(context).pop();
          AutoRouter.of(context).push(const PinPageRoute());
        } else if (Authentication.isSignedIn && value.isEmpty) {
          Navigator.of(context).pop();
          AutoRouter.of(context).push(BottomBarRoute());
        } else {
          Navigator.of(context).pop();
          AutoRouter.of(context).push(const LoginPageRoute());
        }
      } else {
        if (Authentication.isSignedIn) {
          Navigator.of(context).pop();
          AutoRouter.of(context).push(BottomBarRoute());
        } else {
          Navigator.of(context).pop();
          AutoRouter.of(context).push(const LoginPageRoute());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: FlutterLogo(size: MediaQuery.of(context).size.height),
    );
  }
}
