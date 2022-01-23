import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tp_mobile_app/bindings/bottom_bar_binding.dart';
import 'package:tp_mobile_app/routes/router.gr.dart';
import 'package:tp_mobile_app/firebase/authentication.dart';
import 'package:tp_mobile_app/screens/authscreens/passwordreset.dart';
import 'package:tp_mobile_app/screens/authscreens/registrationpage.dart';
import 'package:tp_mobile_app/screens/passwordchange.dart';
import 'package:tp_mobile_app/widgets/animations.dart';
import 'package:tp_mobile_app/widgets/bottombar.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPage createState() => _LoginPage();
}


class _LoginPage extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      resizeToAvoidBottomInset: true,
      body: ListView(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 80),
            color: Colors.blue,
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: TextField(
              controller: emailController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'E-mail'),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Heslo'),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 5.0, 0, 5.0),
            child: (Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Zabudli ste heslo?",
                        style:
                            const TextStyle(color: Colors.blue, fontSize: 16),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.to(() => const PasswordChangePage(), transition: Transition.leftToRight);
                            // Navigator.of(context).push(swipeRouteAnimation(PasswordResetPage()));
                            // AutoRouter.of(context).pop();
                            // AutoRouter.of(context).push(PasswordResetPageRoute());
                          },
                      ),
                    ],
                  ),
                ),
              ],
            )),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: ElevatedButton(
                onPressed: () async {
                  String message =
                      await Authentication.signInWithEmailAndPassword(
                          emailController.text.trim(), passwordController.text);
                  if (Authentication.isSignedIn) {
                    Get.offAll(() => BottomBar(), binding: BottomBarBinding());
                    // Navigator.pop(context);
                    // AutoRouter.of(context).push(BottomBarRoute());
                  } else {
                    passwordController.clear();
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: Text(message),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ));
                  }
                },
                child: const Text("Prihlásenie")),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: ElevatedButton(
              onPressed: () {
                Get.to(() => RegistrationPage(), transition: Transition.leftToRight);
                // AutoRouter.of(context).pop();
                // Navigator.of(context)
                //     .push(swipeRouteAnimation(RegistrationPage()));
              },
              child: const Text("Registrácia"),
              style: ElevatedButton.styleFrom(primary: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
