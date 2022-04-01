import 'dart:async';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:tp_mobile_app/bindings/bottom_bar_binding.dart';
import 'package:tp_mobile_app/controllers/bottom_bar_controller.dart';
import 'package:tp_mobile_app/controllers/mailboxdetail_controller.dart';
import 'package:tp_mobile_app/controllers/mailboxlist_controller.dart';
import 'package:tp_mobile_app/firebase/authentication.dart';
import 'dart:developer' as developer;
import 'package:tp_mobile_app/firebase/database.dart';
import 'package:tp_mobile_app/models/settings.dart';
import 'package:tp_mobile_app/screens/mailboxscreens/mailboxlistpage.dart';
import 'package:tp_mobile_app/widgets/bottombar.dart';

class MailboxDetail extends StatelessWidget {
  const MailboxDetail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MailboxDetailController());
    return StreamBuilder(
        // stream: Database.ref.child("user01").onValue,
        stream: Database.ref.child(Authentication.getUserId ?? "").onValue,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            controller.updateMailboxDetail();
            return FutureBuilder<Settings>(
              future: controller.futureMailbox,
              initialData: Settings(false, false, "", true, true, true, 7, 4, 500, 0.1),
              builder: (BuildContext context, AsyncSnapshot<Settings> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      '${snapshot.error} occurred',
                      style: const TextStyle(fontSize: 18),
                    ),
                  );
                } else if (snapshot.hasData) {
                  controller.setData(snapshot.data);
                  return Scaffold(
                    appBar: AppBar(
                      title: Obx(
                        () => Text(controller.mailbox.name),
                      ),
                      actions: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.edit),
                          tooltip: 'Edit',
                          onPressed: () {
                            controller.titleController.text =
                              controller.mailbox.name;
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Edituj názov'),
                                content: TextField(
                                  controller: controller.titleController,
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      controller.updateMailboxName();
                                      Navigator.pop(context, 'OK');
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              ));
                          },
                        ),
                      ],
                    ),
                    body: ListView(
                      //padding: const EdgeInsets.all(10),
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(
                                top: 15.0,
                                left: 15.0,
                                right: 15.0,
                                bottom: 6.0,
                              ),
                              child: Text(
                                "Nastavenia schránky",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SwitchListTile(
                              title: const Text('Režim nízkej spotreby'),
                              value: controller.mailbox.lowPower,
                              onChanged: (value) => {
                                controller.updateLowPowerMode(value),
                              },
                              // secondary: const Icon(Icons.battery_charging_full),
                            ),
                            const Divider(height: 1),
                            ListTile(
                              title: const Text('Interval medzi kontrolami'),
                              subtitle: Text((controller.mailbox.UCI / 1000000).round().toString()),
                              trailing: const Icon(Icons.keyboard_arrow_right),
                              onTap: (){
                                Get.defaultDialog(
                                  onWillPop: () async {
                                    Timer(const Duration(milliseconds: 500), () {
                                      controller.updateUCI(controller.mailbox.UCI);
                                    });
                                    return true;
                                  },
                                  title: "Interval medzi kontrolami",
                                  onConfirm: () {
                                    Get.back();
                                    Timer(const Duration(milliseconds: 500), () {
                                      controller.updateUCI(controller.mailbox.UCI);
                                    });
                                  },
                                  content: Obx(() => Slider(
                                    value: controller.mailbox.UCI.toDouble(),
                                    onChanged: (value) {
                                      controller.mailbox.UCI = value.round();
                                      controller.updateMailbox();
                                    },
                                    min: 5000000,
                                    max: 300000000,
                                    activeColor: Colors.yellow,
                                    inactiveColor: Colors.yellow[100],
                                    label: (controller.mailbox.UCI / 1000000).round().toString(),
                                    divisions: 295,
                                  ),
                                  )
                                );
                              },
                            ),
                            const Divider(height: 1),
                            ListTile(
                              title: const Text('Kontroly navyse'),
                              // subtitle: const Text('variable prview'),
                              subtitle: Text(controller.mailbox.UEC.round().toString()),
                              trailing: const Icon(Icons.keyboard_arrow_right),
                              onTap: (){
                                Get.defaultDialog(
                                  title: 'Kontroly navyse',
                                  onWillPop: () async {
                                    Timer(const Duration(milliseconds: 500), () {
                                      controller.updateUEC(controller.mailbox.UEC);
                                    });
                                    return true;
                                  },
                                  onConfirm: () {
                                    Get.back();
                                    Timer(const Duration(milliseconds: 500), () {
                                      controller.updateUEC(controller.mailbox.UEC);
                                    });
                                  },
                                  content:
                                    Obx(() => Slider(
                                      value: controller.mailbox.UEC.toDouble(),
                                      onChanged: (value) {
                                        controller.mailbox.UEC = value.round();
                                        controller.updateMailbox();
                                      },
                                      min: 1,
                                      max: 30,
                                      activeColor: Colors.yellow,
                                      inactiveColor: Colors.yellow[100],
                                      label: controller.mailbox.UEC.round().toString(),
                                      divisions: 30,
                                    ),
                                  )
                                );
                              },
                            ),
                            const Divider(height: 1),
                            ListTile(
                              title: const Text('Interval medzi kontrolami navyse'),
                              subtitle: Text(controller.mailbox.UECI.round().toString()),
                              trailing: const Icon(Icons.keyboard_arrow_right),
                              onTap: (){
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) => AlertDialog(
                                    title: const Text('Interval medzi kontrolami navyse'),
                                    content:
                                    Obx(() => Slider(
                                      value: controller.mailbox.UECI.toDouble(),
                                      onChanged: (value) {
                                        controller.updateUECI(value);
                                      },
                                      onChangeEnd: (value) {
                                        controller.updateUECI(value);
                                      },
                                      min: 200,
                                      max: 5000,
                                      activeColor: Colors.yellow,
                                      inactiveColor: Colors.yellow[100],
                                      label: controller.mailbox.UECI.round().toString(),
                                      divisions: 480,
                                    ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context, 'OK');
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  )
                                );
                              },
                            ),
                            const Divider(height: 1),
                            ListTile(
                              title: const Text('Tolerancia'),
                              subtitle: Text(controller.mailbox.UT.round().toString()),
                              trailing: const Icon(Icons.keyboard_arrow_right),
                              onTap: (){
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) => AlertDialog(
                                    title: const Text('Tolerancia'),
                                    content:
                                    Obx(() => Slider(
                                      value: controller.mailbox.UT,
                                      onChanged: (value) {
                                        controller.updateUT(value);
                                      },
                                      onChangeEnd: (value) {
                                        controller.updateUT(value);
                                      },
                                      min: -3,
                                      max: 3,
                                      activeColor: Colors.yellow,
                                      inactiveColor: Colors.yellow[100],
                                      label: controller.mailbox.UT.toStringAsFixed(1),
                                      divisions: 60,
                                    ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context, 'OK');
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  )
                                );
                              },
                            ),
                            const Divider(height: 1),
                          ]
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(
                                top: 15.0,
                                left: 15.0,
                                right: 15.0,
                                bottom: 6.0,
                              ),
                              child: Text(
                                "Notifikácie",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),

                            SwitchListTile(
                              title: const Text('Nová pošta'),
                              value: controller.mailbox.notif_new,
                              onChanged: (value) => {
                                controller.updateNotifyNew(value),
                              },
                            ),
                            const Divider(height: 1),
                            SwitchListTile(
                              title: const Text('Plná schránka'),
                              value: controller.mailbox.notif_full,
                              onChanged: (value) => {
                                controller.updateNotifyFull(value),
                              },
                            ),
                            const Divider(height: 1),
                            SwitchListTile(
                              title: const Text('Prázdna schránka'),
                              value: controller.mailbox.notif_empty,
                              onChanged: (value) => {
                                controller.updateNotifyEmpty(value),
                              },
                            ),
                            const Divider(height: 1),
                            ListTile(
                              title: const Text(''),
                              leading: ElevatedButton(
                                style: ElevatedButton.styleFrom(primary: Colors.red),
                                child: const Text('Reset'),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) => AlertDialog(
                                        title: RichText(
                                          text: const TextSpan(
                                            children: [
                                              WidgetSpan(
                                                child: Icon(
                                                  Icons.warning,
                                                  size: 20,
                                                  color: Colors.red,
                                                ),
                                              ),
                                              TextSpan(
                                                  text: " Reset schránky",
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                            ],
                                          ),
                                        ),
                                        content: const Text(
                                            'Nejaky popis toho co to je za reset a ci si je isty'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, 'Cancel'),
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Database.setReset(
                                                  controller.mailboxId);
                                              Navigator.pop(context, 'OK');
                                            },
                                            child: const Text(
                                              'OK',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ));
                                },
                              ),
                            ),
                          ]
                        ),
                      ],
                    ),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
          }
          else{
            return const Center(child: CircularProgressIndicator(),);
          }
        }
      );
  }
}
