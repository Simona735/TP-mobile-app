import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final pinSize = 4;
  bool isSwitched = false;
  final TextEditingController pin = TextEditingController();
  final TextEditingController confirmPin = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final EncryptedSharedPreferences encryptedSharedPreferences =
      EncryptedSharedPreferences();

  @override
  void initState() {
    super.initState();
    getSwitchValues();
    developer.log("Init");
  }

  getSwitchValues() async {
    isSwitched = (await getSwitchState())!;
    setState(() {});
  }

  Future<bool> saveSwitchState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("switchState", value);
    print('Switch Value saved $value');
    return prefs.setBool("switchState", value);
  }

  Future<void> deletePin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('pin', '');
    developer.log("pin deleted");
  }

  Future<bool?> getSwitchState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isSwitchedFT = prefs.getBool("switchState");
    developer.log(isSwitchedFT.toString());

    return isSwitchedFT;
  }

  bool checkPin() {
    if (pin.text == confirmPin.text &&
        pin.text.length == pinSize &&
        confirmPin.text.length == pinSize) {
      encryptedSharedPreferences.setString('pin', pin.text).then(
        (bool success) {
          if (success) {
            developer.log('success');
            encryptedSharedPreferences.getString('pin').then((String value) {
              developer.log(value);
            });
            return true;
          } else {
            developer.log('fail');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Biometrické prihlásenie"),
              Switch(
                value: isSwitched,
                onChanged: (value) => {
                  setState(
                        () {
                      isSwitched = value;
                    },
                  )
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
