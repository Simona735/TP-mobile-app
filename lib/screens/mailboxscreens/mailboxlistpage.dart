import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:tp_mobile_app/controllers/mailboxdetail_controller.dart';
import 'package:tp_mobile_app/controllers/mailboxlist_controller.dart';
import 'package:tp_mobile_app/firebase/authentication.dart';
import 'package:tp_mobile_app/firebase/database.dart';
import 'package:tp_mobile_app/models/mailbox.dart';
import 'package:tp_mobile_app/routes/router.gr.dart';
import 'package:tp_mobile_app/widgets/animations.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'dart:developer' as developer;

import '../mailboxdetail.dart';

class ListOfMailboxes extends StatelessWidget {
  const ListOfMailboxes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    final controller = Get.find<ListOfMailboxesController>();
    // final controller = Get.put(ListOfMailboxesController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Zoznam schránok"),
        actions: const [
          // IconButton(
          //   onPressed: () {
          //     // controller.onInit();
          //   },
          //   icon: const Icon(
          //     Icons.refresh_outlined,
          //   ),
          // ),
        ],
      ),
      body: StreamBuilder(
        // stream: Database.ref.child("user01").onValue,
        stream: Database.ref.child(Authentication.getUserId ?? "").onValue,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            controller.updateMailboxes();
              return FutureBuilder(
                future: controller.mailboxes.value,
                builder: (BuildContext context, AsyncSnapshot<Object> snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          '${snapshot.error} occurred',
                          style: const TextStyle(fontSize: 18),
                        ),
                      );
                    } else if (snapshot.hasData) {
                      // final data = snapshot.data as Map;
                      controller.setData(snapshot.data);
                      return Column(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              child: GridView.builder(
                                padding: const EdgeInsets.all(10),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      (orientation == Orientation.landscape)
                                          ? 2
                                          : 1,
                                  childAspectRatio: 2.5,
                                  mainAxisSpacing:
                                      (controller.data.isNotEmpty) ? 10 : 0,
                                  crossAxisSpacing:
                                      (controller.data.isNotEmpty) ? 10 : 0,
                                ),
                                itemCount: controller.data.length,
                                itemBuilder: (_, index) {
                                  String key =
                                      controller.data.keys.elementAt(index);
                                  Mailbox value =
                                      controller.data.values.elementAt(index);
                                  return ItemMailbox(
                                    press: () => {
                                      Get.to(() => MailboxDetail(),
                                          arguments: {'mailboxId': key},
                                          transition: Transition.leftToRight),
                                      // Navigator.of(context).push(
                                      //     swipeRouteAnimation(MailboxDetail(
                                      //         mailboxId: key
                                      //     ))
                                      // ),
                                    },
                                    mailbox: value,
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      );
                    }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              );
          }else{
            return const Center(child: CircularProgressIndicator());
          }
        }
      ),
    );
  }
}

class ItemMailbox extends StatelessWidget {
  final VoidCallback press;
  final Mailbox mailbox;

  const ItemMailbox({Key? key, required this.press, required this.mailbox})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      splashColor: Colors.yellow,
      onTap: press,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        alignment: Alignment.topLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Padding(
                    padding: EdgeInsets.only(right: 5.0),
                    child: Icon(
                      Icons.info_outline_rounded,
                      size: 25,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    "Nová pošta",
                    style: TextStyle(color: Colors.black54, fontSize: 16),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                color: Colors.yellow[600],
              ),
              child: Row(
                children: [
                  Text(
                    mailbox.settings.name,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.bolt,
                    size: 30,
                    color: (mailbox.settings.lowPower)
                        ? Colors.green
                        : Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
