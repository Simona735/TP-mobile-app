import 'dart:developer';

import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController extends GetxController{
  final pinSize = 4;
  final isSwitched = false.obs;
  final isDarkTheme = false.obs;
  final TextEditingController pin = TextEditingController();
  final TextEditingController confirmPin = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final EncryptedSharedPreferences encryptedSharedPreferences =
  EncryptedSharedPreferences();

  @override
  void onInit() {
    getSwitchValues();
    super.onInit();
  }

  @override
  void onClose() {
    pin.dispose();
    confirmPin.dispose();
    super.onClose();
  }

  getSwitchValues() async {
    isSwitched.value = (await getSwitchState("switchState")) ?? false;
    isDarkTheme.value = (await getSwitchState("darkTheme")) ?? false;
  }

  Future<bool> saveSwitchState(String keyName, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(keyName, value);
    print('Switch Value saved $value on key $keyName');
    return prefs.setBool(keyName, value);
  }

  Future<void> deletePin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('pin', '');
    saveSwitchState("switchState", false);
    isSwitched.value = false;
    log("pin deleted");
  }

  Future<bool?> getSwitchState(String keyName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isSwitchedFT = prefs.getBool(keyName);
    log(isSwitchedFT.toString());

    return isSwitchedFT;
  }

  bool checkPin() {
    if (pin.text == confirmPin.text &&
        pin.text.length == pinSize &&
        confirmPin.text.length == pinSize) {
      encryptedSharedPreferences.setString('pin', pin.text).then(
            (bool success) {
          if (success) {
            log('success');
            encryptedSharedPreferences.getString('pin').then((String value) {
              log(value);
            });
            return true;
          } else {
            log('fail');
            return false;
          }
        },
      );
    } else {
      return false;
    }
    return true;
  }

  Future<void> showErrorDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Chyba'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('PIN kódy sa nezhodujú'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
