import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:tp_mobile_app/bindings/bottom_bar_binding.dart';
import 'package:tp_mobile_app/controllers/ble_wifi_password_controller.dart';
import 'package:tp_mobile_app/controllers/login_controller.dart';
import 'package:tp_mobile_app/firebase/authentication.dart';
import 'dart:convert';
import 'dart:developer' as developer;
import 'package:tp_mobile_app/firebase/database.dart';
import 'package:get/get.dart';
import 'package:tp_mobile_app/widgets/bottombar.dart';

import '../mailboxdetail.dart';

class DeviceScreen extends StatelessWidget {
  DeviceScreen({Key? key, required this.device}) : super(key: key);

  final wifiNameController = TextEditingController();
  final wifiPasswordController = TextEditingController();
  final userPasswordController = TextEditingController();
  final BluetoothDevice device;


  @override
  Widget build(BuildContext context) {
    final controllerWifi = Get.put(WifiPasswordController());
    final controllerFirebase = Get.put(LoginController());
    BluetoothDeviceState actualState = BluetoothDeviceState.disconnected;
    return Scaffold(
      appBar: AppBar(
        title: Text(device.name),
        actions: <Widget>[
          StreamBuilder<BluetoothDeviceState>(
            stream: device.state,
            initialData: BluetoothDeviceState.connecting,
            builder: (c, snapshot) {
              VoidCallback? onPressed;
              String text;
              actualState = snapshot.data!;
              switch (snapshot.data) {
                case BluetoothDeviceState.connected:
                  onPressed = () => device.disconnect();
                  text = 'Odpojiť';
                  break;
                case BluetoothDeviceState.disconnected:
                  onPressed = () async {
                    try {
                      await device.connect(autoConnect: false);
                    } catch (e) {
                      device.disconnect();
                      developer.log(e.toString());
                    }
                  };
                  text = 'Pripojiť';
                  break;
                default:
                  onPressed = null;
                  text = snapshot.data.toString().substring(21).toUpperCase();
                  break;
              }
              return TextButton(
                onPressed: onPressed,
                child: Text(
                  text,
                  style: Theme.of(context)
                      .primaryTextTheme
                      .button
                      ?.copyWith(color: Colors.white),
                ),
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StreamBuilder<BluetoothDeviceState>(
              stream: device.state,
              initialData: BluetoothDeviceState.connecting,
              builder: (c, snapshot) => ListTile(
                leading: (snapshot.data == BluetoothDeviceState.connected)
                    ? const Icon(Icons.bluetooth_connected,
                                  color: Colors.blue,)
                    : const Icon(Icons.bluetooth_disabled, color: Colors.redAccent,),
                title: Text(
                    'Zariadenie je ' + (snapshot.data.toString().split('.')[1] == 'connected' ? 'pripojené' : 'odpojené')
                ),
                trailing: ElevatedButton(
                  child: const Text("Reset"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                  onPressed: () async {
                    if (actualState == BluetoothDeviceState.disconnected){
                      try {
                        await device.connect();
                      } catch(e) {
                        developer.log(e.toString());
                      }
                    }
                    List<BluetoothService> services = await device.discoverServices();
                    var characteristic = services[2].characteristics[0];
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text("Zariadenie sa resetuje."),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                characteristic.write(utf8.encode(
                                    "+FRST;0")
                                );
                                Get.offAll(() => BottomBar(), binding: BottomBarBinding());
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        )
                    );
                  },
                ),
              ),
            ),
            StreamBuilder<List<BluetoothService>>(
              stream: device.services,
              initialData: [],
              builder: (c, snapshot) {
                return Column(
                  children: [
                    const Divider(thickness: 1),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              margin: const EdgeInsets.all(10),
                              child: const Text('Nastavenie WiFi',
                                style: TextStyle(fontSize: 20),
                              )
                          ),
                          Container(
                              margin: const EdgeInsets.all(10),
                              child: TextField(
                                controller: wifiNameController,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Názov siete'),
                              )
                          ),
                          Container(
                            margin: const EdgeInsets.all(10),
                            child: Obx(
                            () =>  TextField(
                                controller: wifiPasswordController,
                                obscureText: controllerWifi.showPassword.value,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: 'Heslo',
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      controllerWifi.showPassword.value =
                                      !controllerWifi.showPassword.value;
                                    },
                                    icon: Icon(controllerWifi.showPassword.value
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              var mailboxCountStr = await Database.getMailboxIter();
                              var mailboxCount = int.parse(mailboxCountStr);
                              if (mailboxCount >= 30){
                                showDialog(
                                    context: context,
                                    builder: (
                                        BuildContext context) =>
                                        AlertDialog(
                                          title: const Text(
                                              "Bol prekročený limit schránok. Pred pridaním novej schránky najprv nejakú odstráňte."),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Get.offAll(() => BottomBar(), binding: BottomBarBinding());
                                              },
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        )
                                );
                              }else {
                                if (actualState ==
                                    BluetoothDeviceState.disconnected) {
                                  try {
                                    await device.connect();
                                  } catch (e) {
                                    developer.log(e.toString());
                                  }
                                };
                                List<BluetoothService> services = await device
                                    .discoverServices();
                                if (services.length != 3) {
                                  developer.log("not enough services");
                                }
                                var characteristics = services[2]
                                    .characteristics;
                                for (BluetoothCharacteristic c in characteristics) {
                                  await c.read();
                                }
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          title: const Text(
                                              'Pre overenie vyplň svoje heslo.'),
                                          content: Obx(
                                                () =>
                                                TextField(
                                                  controller: userPasswordController,
                                                  obscureText: controllerFirebase
                                                      .showPassword.value,
                                                  decoration: InputDecoration(
                                                    border: const OutlineInputBorder(),
                                                    labelText: 'Heslo',
                                                    suffixIcon: IconButton(
                                                      onPressed: () {
                                                        controllerFirebase
                                                            .showPassword
                                                            .value =
                                                        !controllerFirebase
                                                            .showPassword.value;
                                                      },
                                                      icon: Icon(
                                                          controllerFirebase
                                                              .showPassword
                                                              .value
                                                              ? Icons.visibility
                                                              : Icons
                                                              .visibility_off),
                                                    ),
                                                  ),
                                                ),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () async {
                                                var isVerified = await Authentication.verifyUser(userPasswordController.text);
                                                if (!isVerified){
                                                  showDialog(
                                                      context: context,
                                                      builder: (
                                                          BuildContext context) =>
                                                          AlertDialog(
                                                            title: const Text(
                                                                "Nesprávne heslo."),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                onPressed: () {
                                                                  Get.back();
                                                                },
                                                                child: const Text(
                                                                    'OK'),
                                                              ),
                                                            ],
                                                          )
                                                  );
                                                }else{
                                                  var characteristic = services[2]
                                                      .characteristics[0];
                                                  await characteristic.write(
                                                      utf8.encode(
                                                          "WS;" +
                                                              wifiNameController
                                                                  .text.trim())
                                                  );
                                                  await characteristic.write(
                                                      utf8.encode(
                                                          "WP;" +
                                                              wifiPasswordController
                                                                  .text)
                                                  );
                                                  await characteristic.write(
                                                      utf8.encode(
                                                          "FBP;" +
                                                              userPasswordController
                                                                  .text)
                                                  );
                                                  await characteristic.write(
                                                      utf8.encode(
                                                          "FBM;" + (Authentication
                                                              .getUserEmail ??
                                                              '-'))
                                                  );
                                                  await characteristic.write(
                                                      utf8.encode(
                                                          "FBU;" + (Authentication
                                                              .getUserId ?? '-'))
                                                  );
                                                  await characteristic.read();
                                                  String mailboxId = await Database
                                                      .createMailbox();
                                                  await characteristic.write(
                                                      utf8.encode(
                                                          "FBI;" + mailboxId)
                                                  );
                                                  characteristic.write(
                                                      utf8.encode(
                                                          "+CONF;0"),
                                                      withoutResponse: true
                                                  ).then((value) {
                                                    showDialog(
                                                        context: context,
                                                        builder: (
                                                            BuildContext context) =>
                                                            AlertDialog(
                                                              title: const Text(
                                                                  "Zariadenie sa pokúsi pripojiť k sieti. "),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  onPressed: () {
                                                                    device
                                                                        .disconnect();
                                                                    Get.back();
                                                                    Get.back();
                                                                    Get.back();
                                                                    Get.to(() => MailboxDetail(),
                                                                        arguments: {'mailboxId': mailboxId});
                                                                  },
                                                                  child: const Text(
                                                                      'OK'),
                                                                ),
                                                              ],
                                                            )
                                                    );
                                                  });
                                                }
                                              },
                                              child: const Text('Pripojiť'),
                                            ),
                                          ],
                                        )
                                );
                              }
                            },
                            child: const Text("Potvrdiť"),
                          ),
                        ],
                      )
                      ,
                    )
                  ]
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
