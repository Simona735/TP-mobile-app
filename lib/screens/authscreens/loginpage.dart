import 'package:flutter/material.dart';
import 'package:tp_mobile_app/screens/authscreens/registrationpage.dart';
import 'package:tp_mobile_app/widgets/animations.dart';

import '../manager.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      resizeToAvoidBottomInset: true,
      body: ListView(
        children: <Widget>[
        ],
      ),
    );
  }
}
