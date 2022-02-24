import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:tp_mobile_app/screens/bluetooth/bluetooth_device.dart';
import 'dart:developer' as developer;

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
                  if (result.device.name != "") {
                    return ListTile(
                      leading: const Icon(
                        Icons.markunread_mailbox_outlined,
                        size: 30.0,
                      ),
                      title: Text(result.device.name,
                        style: const TextStyle(fontSize: 20),
                      ),
                      onTap: () async {
                          await result.device.connect(autoConnect: true);
                          result.device.requestMtu(92);
                          Get.to(() => DeviceScreen(device: result.device), transition: Transition.leftToRight);
                        //   Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) {
                        //       // AutoRouter.of(context).push(DeviceScreenRoute(device: result.device));
                        //       return DeviceScreen(device: result.device);
                        //     },
                        //   ),
                        // );
                      }
                    );
                  }
                  else {
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
                backgroundColor: Colors.blue,
                onPressed: () => FlutterBlue.instance
                    .startScan(timeout: const Duration(seconds: 4)));
          }
        },
      ),
    );
  }
}
