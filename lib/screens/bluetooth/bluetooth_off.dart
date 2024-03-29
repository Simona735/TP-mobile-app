import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BluetoothOffScreen extends StatelessWidget {
  const BluetoothOffScreen({Key? key, this.state}) : super(key: key);

  final BluetoothState? state;

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.bluetooth_disabled,
              size: (orientation == Orientation.landscape) ? 150.0 : 200.0,
              color: Colors.white54,
            ),
            Text(
              'Bluetooth Adapter je ${state != null ? 'vypnutý' : 'nedostupny'}.',
            ),
          ],
        ),
      ),
    );
  }
}
