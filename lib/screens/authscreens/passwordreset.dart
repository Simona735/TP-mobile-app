import 'package:flutter/material.dart';
import 'package:tp_mobile_app/firebase/authentication.dart';
import 'package:get/get.dart';

class PasswordResetPage extends StatelessWidget {
  PasswordResetPage({Key? key}) : super(key: key);

  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Zabudli ste heslo?"),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(30),
            child: (
              const Text(
                "Zadajte emailovú adresu, na ktorú vám odošleme email.",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              )
            ),
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
            margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: ElevatedButton(
              onPressed: () async {
                await Authentication.sendPasswordResetEmail(emailController.text.trim());
                showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text("Skontrolujte si emailovú schránku"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Get.back();
                            Get.back();
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    )
                );
              },
              child: const Text("Resetuj heslo"),
            ),
          ),
        ],
      ),
    );
  }
}

