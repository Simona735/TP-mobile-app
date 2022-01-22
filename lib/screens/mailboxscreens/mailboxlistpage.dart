import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:tp_mobile_app/controllers/mailboxdetail_controller.dart';
import 'package:tp_mobile_app/controllers/mailboxlist_controller.dart';
import 'package:tp_mobile_app/firebase/database.dart';
import 'package:tp_mobile_app/routes/router.gr.dart';
import 'package:tp_mobile_app/widgets/animations.dart';
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
        actions: [
          IconButton(
            onPressed: () {
              controller.onInit();
            },
            icon: const Icon(
              Icons.refresh_outlined,
            ),
          )
        ],
      ),
      body: GetX<ListOfMailboxesController>(
        init: controller,
        builder: (controller) {
          return FutureBuilder(
            future: controller.mailboxes.value,
            initialData: 'Loading...',
            builder: (BuildContext context, AsyncSnapshot<Object> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
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
                              childAspectRatio: 2,
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
                                  Get.to(() => const MailboxDetail(),
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
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        },
      ),
    );
  }
}

class ItemMailbox extends StatelessWidget {
  final VoidCallback press;
  final String name;

  const ItemMailbox({Key? key, required this.press, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      splashColor: Colors.yellow,
      onTap: press,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              name,
              style: const TextStyle(color: Colors.black, fontSize: 18),
            ),
            const Icon(
              Icons.bolt,
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
