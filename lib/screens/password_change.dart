import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tp_mobile_app/firebase/authentication.dart';
import 'package:tp_mobile_app/routes/router.gr.dart';

class PasswordChangePage extends StatelessWidget {
  PasswordChangePage({Key? key}) : super(key: key);

  final oldPasswordController = TextEditingController();
  final newPassword1Controller = TextEditingController();
  final newPassword2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Zmena hesla"),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 80),
            color: Colors.blue,
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: TextField(
              controller: oldPasswordController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Aktuálne heslo'),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: TextField(
              controller: newPassword1Controller,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Nové heslo'),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: TextField(
              controller: newPassword2Controller,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Zopakuj nové heslo'),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: ElevatedButton(
              onPressed: () async {
                if(newPassword1Controller.text == newPassword2Controller.text){
                  String message = await Authentication.changePassword(oldPasswordController.text, newPassword1Controller.text);
                  if(message == 'OK'){
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Heslo bolo zmenené'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        )
                    );
                    //TODO go back to profile
                  }else{
                    oldPasswordController.clear();
                    newPassword1Controller.clear();
                    newPassword2Controller.clear();
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
                        )
                    );
                  }
                }else{
                  newPassword1Controller.clear();
                  newPassword2Controller.clear();
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text("Nové heslo sa nezhoduje"),
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
              child: const Text("Zmeň heslo"),
            ),
          ),
        ],
      ),
    );
  }
}

