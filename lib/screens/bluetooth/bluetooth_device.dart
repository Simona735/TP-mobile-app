import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:tp_mobile_app/firebase/authentication.dart';
import 'dart:convert';
import 'dart:developer' as developer;
import 'package:tp_mobile_app/firebase/database.dart';

class DeviceScreen extends StatelessWidget {
  DeviceScreen({Key? key, required this.device}) : super(key: key);

  final wifiNameController = TextEditingController();
  final wifiPasswordController = TextEditingController();
  final userPasswordController = TextEditingController();
  final BluetoothDevice device;


  @override
  Widget build(BuildContext context) {
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
              switch (snapshot.data) {
                case BluetoothDeviceState.connected:
                  onPressed = () => device.disconnect();
                  text = 'DISCONNECT';
                  break;
                case BluetoothDeviceState.disconnected:
                  onPressed = () async {
                    try {
                      await device.connect(autoConnect: true);
                    } catch (e) {
                      device.disconnect();
                      developer.log(e.toString());
                    }
                  };
                  text = 'CONNECT';
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
                    : const Icon(Icons.bluetooth_disabled),
                title: Text(
                    'Zariadenie je ' + (snapshot.data.toString().split('.')[1] == 'connected' ? 'pripojené' : 'odpojené')
                ),
              ),
            ),
            StreamBuilder<List<BluetoothService>>(
              stream: device.services,
              initialData: [],
              builder: (c, snapshot) {
                return Column(
                  children: [
                    const Divider(
                      thickness: 1,
                    ),
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
                            child: TextField(
                              controller: wifiPasswordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Heslo'),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              // await snapshot.data![2].characteristics[0].write(utf8.encode(
                              //     "+FRST;0")
                              // );
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Pre overenie vyplň svoje heslo.'),
                                  content: TextField(
                                    controller: userPasswordController,
                                    obscureText: true,
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () async {
                                        //TODO loading indicator (optional)
                                        String mailboxId = await Database.createMailbox();
                                        var characteristic = snapshot.data![2].characteristics[0];
                                        await characteristic.write(utf8.encode(
                                            "WS;" + wifiNameController.text.trim())
                                        );
                                        await characteristic.write(utf8.encode(
                                            "WP;" + wifiPasswordController.text)
                                        );
                                        await characteristic.write(utf8.encode(
                                            "FBP;" + userPasswordController.text)
                                        );
                                        await characteristic.write(utf8.encode(
                                            "FBM;" + (Authentication.getUserEmail ?? '-'))
                                        );
                                        await characteristic.write(utf8.encode(
                                            "FBU;" + (Authentication.getUserId ?? '-'))
                                        );
                                        await characteristic.write(utf8.encode(
                                            "FBI;" + mailboxId)
                                        );
                                        characteristic.write(utf8.encode(
                                            "+CONF;0"), withoutResponse: true
                                        ).then((value) {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) => AlertDialog(
                                                title: const Text("Zariadenie sa pokúsi pripojiť k sieti. "),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context, 'OK');
                                                      Navigator.pop(context, 'Pripojiť');
                                                      device.disconnect();
                                                      Navigator.of(context).pop();
                                                      //TODO routing
                                                      // AutoRouter.of(context).push(BottomBarRoute());
                                                    },
                                                    child: const Text('OK'),
                                                  ),
                                                ],
                                              )
                                          );
                                        });
                                      },
                                      child: const Text('Pripojiť'),
                                    ),
                                  ],
                                )
                              );
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
