import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:tp_mobile_app/screens/bluetooth/bluetooth_find.dart';
import 'package:tp_mobile_app/screens/bluetooth/bluetooth_off.dart';

class AddMailbox extends StatelessWidget {
  const AddMailbox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<BluetoothState>(
        stream: FlutterBlue.instance.state,
        initialData: BluetoothState.unknown,
        builder: (c, snapshot) {
          final state = snapshot.data;
          if (state == BluetoothState.on) {
            return const FindDevicesScreen();
          }
          return BluetoothOffScreen(state: state);
        },
      ),
    );
  }
}
