import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'dart:convert';
import 'dart:developer' as developer;

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
                              await snapshot.data![2].characteristics[0].write(utf8.encode(
                                  nameController.text.trim() + ';' + passwordController.text)
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
