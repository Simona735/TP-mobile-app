import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tp_mobile_app/controllers/passwordchange_controller.dart';
import 'package:tp_mobile_app/firebase/authentication.dart';
import 'package:tp_mobile_app/routes/router.gr.dart';
import 'package:tp_mobile_app/screens/mailboxscreens/profilepage.dart';

class PasswordChangePage extends StatelessWidget {
  const PasswordChangePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PasswordChangeController());
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
              controller: controller.oldPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Aktuálne heslo'),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: TextField(
              controller: controller.newPassword1Controller,
              obscureText: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Nové heslo'),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: TextField(
              controller: controller.newPassword2Controller,
              obscureText: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Zopakuj nové heslo'),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: ElevatedButton(
              onPressed: () async {
                if(controller.newPassword1Controller.text == controller.newPassword2Controller.text){
                  String message = await Authentication.changePassword(controller.oldPasswordController.text, controller.newPassword1Controller.text);
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
                    Navigator.of(context)..pop()..pop();
                    AutoRouter.of(context).push(const ProfilePageRoute());
                  }else{
                    controller.oldPasswordController.clear();
                    controller.newPassword1Controller.clear();
                    controller.newPassword2Controller.clear();
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
                  controller.newPassword1Controller.clear();
                  controller.newPassword2Controller.clear();
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

