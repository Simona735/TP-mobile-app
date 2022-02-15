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
        stream: Database.ref.child("user01").onValue,
        // stream: Database.ref.child(Authentication.getUserId ?? "").onValue,
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
                      padding: const EdgeInsets.all(10),
                      children: [
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Container(
                        //       margin: const EdgeInsets.all(10),
                        //       child: Obx(
                        //         () => CircularStepProgressIndicator(
                        //           // totalSteps: controller.data['limit'].round(),
                        //           // totalSteps: controller.mailbox.limit.round(),
                        //           totalSteps: controller.mailbox.limit.round(),
                        //           currentStep: controller.listPercentage,
                        //           circularDirection:
                        //               CircularDirection.counterclockwise,
                        //           stepSize: 5,
                        //           selectedColor: controller.listPercentage <=
                        //                   controller.mailbox.limit.round()
                        //               ? Colors.yellow
                        //               : Colors.red,
                        //           unselectedColor: Colors.grey[200],
                        //           padding: 0,
                        //           width: 150,
                        //           height: 150,
                        //           selectedStepSize: 15,
                        //           roundedCap: (_, __) => true,
                        //           child: Center(
                        //               child: Column(
                        //             mainAxisAlignment: MainAxisAlignment.center,
                        //             children: [
                        //               Text(
                        //                 (controller.mailbox.limit.round() <
                        //                         controller.listPercentage)
                        //                     ? 'Full'
                        //                     : controller.listPercentage.toString() +
                        //                         "%",
                        //                 style: const TextStyle(
                        //                     fontWeight: FontWeight.bold,
                        //                     fontSize: 25),
                        //               ),
                        //             ],
                        //           )),
                        //         ),
                        //       ),
                        //     )
                        //   ],
                        // ),
                        Column(
                          children: [
                            // Obx(
                            //   () => Slider(
                            //     // value: snapshot.data!.limit.toDouble(),
                            //     value: controller.mailbox.limit.toDouble(),
                            //     onChanged: (value) {
                            //       controller.updateLimit(value);
                            //     },
                            //     onChangeEnd: (value) {
                            //       controller.updateLimit(value);
                            //       Database.updateLimit(controller.mailboxId,
                            //           controller.mailbox.limit.toInt());
                            //     },
                            //     min: 1.0,
                            //     max: 100.0,
                            //     activeColor: Colors.yellow,
                            //     inactiveColor: Colors.yellow[100],
                            //     label: controller.mailbox.limit.round().toString(),
                            //     divisions: 99,
                            //   ),
                            // ),
                            // Obx(
                            //   () => Text(
                            //     "Limit: " +
                            //         // controller.mailbox.limit.round().toString() +
                            //         controller.mailbox.limit.round().toString() +
                            //         "%",
                            //     style: const TextStyle(fontSize: 20),
                            //   ),
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  child: const Text(
                                    "Low power mode",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                Obx(
                                  () => Switch(
                                    // value: controller.data["low_power"],
                                    value: controller.mailbox.lowPower,
                                    onChanged: (value) => {
                                      controller.updateLowPowerMode(value),
                                    },
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Column(
                          children: [
                            ElevatedButton(
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
                              child: const Text("Reset"),
                              style: ElevatedButton.styleFrom(primary: Colors.red),
                            ),
                          ],
                        )
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
