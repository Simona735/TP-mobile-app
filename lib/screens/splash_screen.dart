import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tp_mobile_app/firebase/authentication.dart';
import 'package:tp_mobile_app/routes/router.gr.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (Authentication.isSignedIn) {
        Navigator.of(context).pop();
        AutoRouter.of(context).push(BottomBarRoute());
      } else {
        Navigator.of(context).pop();
        AutoRouter.of(context).push(const LoginPageRoute());
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
