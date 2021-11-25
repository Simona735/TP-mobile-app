import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tp_mobile_app/firebase/authentication.dart';
import 'package:tp_mobile_app/routes/router.gr.dart';

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
            margin: const EdgeInsets.only(top: 80),
            color: Colors.blue,
          ),
          Container(
            margin: const EdgeInsets.only(top: 80),
            color: Colors.blue,
            child: (
                const Text(
                    "Zadajte emailovú adresu, na ktorú vám odošleme email, pomocou ktorého si obnovíte heslo.",
                    style: TextStyle(fontSize: 16)
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
                await Authentication.sendPasswordResetEmail(emailController.text);
                showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text("Skontrolujte si emailovú schránku"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    )
                );
                Navigator.pop(context);
              },
              child: const Text("Resetuj heslo"),
            ),
          ),
        ],
      ),
    );
  }
}

