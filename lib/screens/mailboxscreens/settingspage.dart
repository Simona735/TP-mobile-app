import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
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
    isSwitched = (await getSwitchState("switchState")) ?? false;
    isDarkTheme = (await getSwitchState("darkTheme")) ?? false;
    setState(() {});
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
    developer.log("pin deleted");
  }

  Future<bool?> getSwitchState(String keyName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isSwitchedFT = prefs.getBool(keyName);
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
    setState(() {});
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nastavenia"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Icon(Icons.fingerprint, size: 35),
                    Padding(
                      padding: EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                      child: Text("Biometrické prihlásenie",
                          style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
                Switch(
                  value: isSwitched,
                  onChanged: (value) => {
                    setState(
                      () {
                        isSwitched = value;
                        saveSwitchState("switchState", value);
                        if (isSwitched == true) {
                          pin.clear();
                          confirmPin.clear();
                          showMaterialModalBottomSheet(
                            barrierColor: Colors.black26,
                            context: context,
                            builder: (context) => WillPopScope(
                              onWillPop: () async {
                                deletePin();
                                setState(() {
                                  isSwitched = false;
                                  saveSwitchState("switchState", false);
                                });
                                return true;
                              },
                              child: SingleChildScrollView(
                                controller: ModalScrollController.of(context),
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: Column(
                                    children: [
                                      Form(
                                        key: _formKey,
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              obscureText: true,
                                              maxLength: pinSize,
                                              style:
                                                  const TextStyle(fontSize: 20),
                                              textAlign: TextAlign.center,
                                              textInputAction:
                                                  TextInputAction.next,
                                              controller: pin,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Pole je prázdne';
                                                }
                                                if (value.length < pinSize) {
                                                  return 'PIN je príliš krátky';
                                                }
                                                return null;
                                              },
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(r'[0-9]')),
                                              ],
                                              decoration: const InputDecoration(
                                                  labelText: 'Zadaj PIN'),
                                            ),
                                            TextFormField(
                                              obscureText: true,
                                              maxLength: pinSize,
                                              style:
                                                  const TextStyle(fontSize: 20),
                                              textAlign: TextAlign.center,
                                              textInputAction:
                                                  TextInputAction.next,
                                              controller: confirmPin,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Pole je prázdne';
                                                }
                                                if (value.length < pinSize) {
                                                  return 'PIN je príliš krátky';
                                                }
                                                return null;
                                              },
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(r'[0-9]')),
                                              ],
                                              decoration: const InputDecoration(
                                                  labelText: 'Potvrď PIN'),
                                            ),
                                          ],
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            checkPin()
                                                ? Navigator.of(context).pop()
                                                : showErrorDialog(context);
                                          }
                                        },
                                        child: const Text("Uložiť"),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                    if (isSwitched == false)
                      {
                        deletePin(),
                      }
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
