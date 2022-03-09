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
              initialData: Settings(false, false, ""),
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
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 15.0,
                                left: 15.0,
                                right: 15.0,
                                bottom: 6.0,
                              ),
                              child: Text(
                                "Nastavenia schránky",
                                style: TextStyle(
                                  color: Theme.of(context).accentColor,
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
                              secondary: const Icon(Icons.battery_charging_full),
                            ),
                            const Divider(height: 1),
                            ListTile(
                              title: const Text('UCI Interval medzi kontrolami'),
                              subtitle: const Text('Here is a second line'),
                              trailing: const Icon(Icons.keyboard_arrow_right),
                              onTap: (){
                                print('Star');
                              },
                            ),
                            const Divider(height: 1),
                            ListTile(
                              title: const Text('UEC Kontroly navyse'),
                              subtitle: const Text('Here is a second line'),
                              trailing: const Icon(Icons.keyboard_arrow_right),
                              onTap: (){
                                print('Star');
                              },
                            ),
                            const Divider(height: 1),
                            ListTile(
                              title: const Text('UECI Interval medzi kontrolami navyse'),
                              subtitle: const Text('Here is a second line'),
                              trailing: const Icon(Icons.keyboard_arrow_right),
                              onTap: (){
                                print('Star');
                              },
                            ),
                            const Divider(height: 1),
                            ListTile(
                              title: const Text('UT Tolerancia'),
                              subtitle: const Text('Here is a second line'),
                              trailing: const Icon(Icons.keyboard_arrow_right),
                              onTap: (){
                                print('Star');
                              },
                            ),
                            const Divider(height: 1),
                          ]
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 15.0,
                                left: 15.0,
                                right: 15.0,
                                bottom: 6.0,
                              ),
                              child: Text(
                                "Notifikácie",
                                style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),

                            SwitchListTile(
                              title: const Text('Nová pošta'),
                              value: controller.mailbox.lowPower,
                              onChanged: (value) => {
                                controller.updateLowPowerMode(value),
                              },
                            ),
                            const Divider(height: 1),
                            SwitchListTile(
                              title: const Text('Plná schránka'),
                              value: controller.mailbox.lowPower,
                              onChanged: (value) => {
                                controller.updateLowPowerMode(value),
                              },
                            ),
                            const Divider(height: 1),
                            SwitchListTile(
                              title: const Text('Prázdna schránka'),
                              value: controller.mailbox.lowPower,
                              onChanged: (value) => {
                                controller.updateLowPowerMode(value),
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
