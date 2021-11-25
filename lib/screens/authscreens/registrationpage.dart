import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tp_mobile_app/firebase/authentication.dart';
import 'package:tp_mobile_app/routes/router.gr.dart';

class RegistrationPage extends StatelessWidget {
  RegistrationPage({Key? key}) : super(key: key);

  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final emailController = TextEditingController();
  final password1Controller = TextEditingController();
  final password2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registrácia"),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 80),
            color: Colors.blue,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Meno'),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: TextField(
                    controller: surnameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Priezvisko'),
                  ),
                ),
              ),
            ],
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
              controller: password1Controller,
              obscureText: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Heslo'),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: TextField(
              controller: password2Controller,
              obscureText: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Opakovanie hesla'),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: ElevatedButton(
              onPressed: () {
                if(password1Controller.text == password2Controller.text){
                  Authentication.registerAccount(
                      nameController.text,
                      surnameController.text,
                      emailController.text,
                      password1Controller.text);
                  Navigator.pop(context);
                  AutoRouter.of(context).push(BottomBarRoute());
                }else{
                  password1Controller.clear();
                  password2Controller.clear();
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text("Heslá sa nezhodujú"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      )
                  );
                }
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

