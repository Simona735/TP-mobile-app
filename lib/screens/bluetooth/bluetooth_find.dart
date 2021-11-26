import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:tp_mobile_app/screens/bluetooth/bluetooth_device.dart';

class FindDevicesScreen extends StatelessWidget {
  const FindDevicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StreamBuilder<List<ScanResult>>(
              stream: FlutterBlue.instance.scanResults,
              initialData: [],
              builder: (c, snapshot) => Column(
                children: snapshot.data!.map((result) {
                  if (result.device.name == "MailBox") {
                    return ListTile(
                      leading: const Icon(
                        Icons.markunread_mailbox_outlined,
                        size: 30.0,
                      ),
                      title: Text(result.device.name == ""
                          ? "No Name "
                          : result.device.name,
                        style: const TextStyle(fontSize: 20),
                      ),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            result.device.connect();
                            result.device.discoverServices();
                            // AutoRouter.of(context).push(DeviceScreenRoute(device: result.device));
                            return DeviceScreen(device: result.device);
                          },
                        ),
                      ),
                    );
                  }
                  else {
                    print("None: " + result.device.id.toString());
                    return const SizedBox.shrink();
                  }
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: StreamBuilder<bool>(
        stream: FlutterBlue.instance.isScanning,
        initialData: false,
        builder: (c, snapshot) {
          if (snapshot.data!) {
            return FloatingActionButton(
              child: const Icon(Icons.stop),
              onPressed: () => FlutterBlue.instance.stopScan(),
              backgroundColor: Colors.red,
            );
          } else {
            return FloatingActionButton(
                child: const Icon(Icons.search),
                onPressed: () => FlutterBlue.instance
                    .startScan(timeout: const Duration(seconds: 4)));
          }
        },
      ),
    );
  }
}
