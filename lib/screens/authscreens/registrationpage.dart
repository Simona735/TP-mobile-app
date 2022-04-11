import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tp_mobile_app/bindings/bottom_bar_binding.dart';
import 'package:tp_mobile_app/controllers/login_controller.dart';
import 'package:tp_mobile_app/controllers/registration_controller.dart';
import 'package:tp_mobile_app/firebase/authentication.dart';
import 'package:tp_mobile_app/firebase/database.dart';
import 'package:tp_mobile_app/widgets/bottombar.dart';

class RegistrationPage extends StatelessWidget {
  RegistrationPage({Key? key}) : super(key: key);

  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final emailController = TextEditingController();
  final password1Controller = TextEditingController();
  final password2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegistrationController());
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
            child: Obx(
              () => TextField(
                controller: password1Controller,
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
            margin: const EdgeInsets.all(10),
            child: Obx(() => TextField(
                  controller: password2Controller,
                  obscureText: controller.showRepeatPassword.value,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Opakovanie hesla',
                    suffixIcon: IconButton(
                      onPressed: () {
                        controller.showRepeatPassword.value =
                            !controller.showRepeatPassword.value;
                      },
                      icon: Icon(controller.showRepeatPassword.value
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                  ),
                ),
              ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: ElevatedButton(
              onPressed: () async {
                if(password1Controller.text == password2Controller.text){
                  String message = await Authentication.registerAccount(
                    nameController.text.trim(),
                    surnameController.text.trim(),
                    emailController.text.trim(),
                    password1Controller.text);
                  if(Authentication.isSignedIn){
                    Database.createUser();
                    Get.offAll(() => BottomBar(), binding: BottomBarBinding());
                  }else{
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
                }else{
                  password1Controller.clear();
                  password2Controller.clear();
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text("Heslá sa nezhodujú"),
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
              child: const Text("Registrácia"),
              style: ElevatedButton.styleFrom(primary: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

