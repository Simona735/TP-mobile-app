import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tp_mobile_app/bindings/bottom_bar_binding.dart';
import 'package:tp_mobile_app/controllers/login_controller.dart';
import 'package:tp_mobile_app/firebase/authentication.dart';
import 'package:tp_mobile_app/screens/authscreens/passwordreset.dart';
import 'package:tp_mobile_app/screens/authscreens/registrationpage.dart';
import 'package:tp_mobile_app/screens/passwordchange.dart';
import 'package:tp_mobile_app/widgets/animations.dart';
import 'package:tp_mobile_app/widgets/bottombar.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Prihlásenie"),
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
            child: Obx(
              () => TextField(
                controller: passwordController,
                obscureText: controller.showPassword.value,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Heslo',
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.showPassword.value =
                          !controller.showPassword.value;
                    },
                    icon: Icon(controller.showPassword.value
                        ? Icons.visibility
                        : Icons.visibility_off),
                  ),
                ),
              ),
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
                            Get.to(() => PasswordResetPage(), transition: Transition.leftToRight);
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
                  } else {
                    passwordController.clear();
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: Text(message),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Get.back(),
                                  child: const Text('OK'),
                                ),
                              ],
                            )
                    );
                  }
                },
                child: const Text("Prihlásenie")),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: ElevatedButton(
              onPressed: () {
                Get.to(() => RegistrationPage(), transition: Transition.leftToRight);
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
