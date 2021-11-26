import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:tp_mobile_app/screens/bluetooth/service_tile.dart';
import 'dart:convert';
import 'dart:developer' as developer;

class DeviceScreen extends StatelessWidget {
  const DeviceScreen({Key? key, required this.device}) : super(key: key);

  final BluetoothDevice device;


  Widget buildWiFiField(BluetoothService service) {
    final nameController = TextEditingController();
    final passwordController = TextEditingController();

    return Padding(
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
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Heslo'),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await service.characteristics[0].write(utf8.encode(
                nameController.text.trim() + passwordController.text)
              );
              //TODO after data send
            },
            child: const Text("Pripojiť"),
          ),
        ],
      )
      ,
    );
  }

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
                      final mtu = await device.mtu.first;
                      developer.log(mtu.toString());
                      await device.requestMtu(512);
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
                    'Device is ${snapshot.data.toString().split('.')[1]}.'),
                // subtitle: Text('${device.id}'),
                trailing: StreamBuilder<bool>(
                  stream: device.isDiscoveringServices,
                  initialData: false,
                  builder: (c, snapshot) => IndexedStack(
                    index: snapshot.data! ? 1 : 0,
                    children: <Widget>[
                      TextButton(
                        child: const Text("Show Services"),
                        onPressed: () => device.discoverServices(),
                      ),
                      const IconButton(
                        icon: SizedBox(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.grey),
                          ),
                          width: 18.0,
                          height: 18.0,
                        ),
                        onPressed: null,
                      )
                    ],
                  ),
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
                    buildWiFiField(snapshot.data![2])
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
