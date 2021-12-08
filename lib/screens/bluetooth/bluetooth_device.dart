import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:tp_mobile_app/firebase/authentication.dart';
import 'dart:convert';
import 'dart:developer' as developer;

import 'package:tp_mobile_app/firebase/database.dart';

class DeviceScreen extends StatelessWidget {
  DeviceScreen({Key? key, required this.device}) : super(key: key);

  final nameController = TextEditingController();
  final passwordController = TextEditingController();
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
                                controller: nameController,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Názov siete'),
                              )
                          ),
                          Container(
                            margin: const EdgeInsets.all(10),
                            child: TextField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Heslo'),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              String mailboxId = Database.createMailbox();
                              await snapshot.data![2].characteristics[0].write(utf8.encode(
                                  nameController.text.trim() + ';' +
                                  passwordController.text + ';' +
                                  (Authentication.getUserId ?? '-') + ';' +
                                  mailboxId)
                              );
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) => AlertDialog(
                                    title: const Text("Zariadenie sa pokúsi pripojiť k sieti."),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () => Navigator.pop(context, 'OK'),
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  )
                              );
                              device.disconnect();
                              //TODO after data send
                            },
                            child: const Text("Pripojiť"),
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
