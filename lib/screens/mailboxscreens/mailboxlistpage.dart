import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tp_mobile_app/firebase/database.dart';
import 'package:tp_mobile_app/routes/router.gr.dart';
import 'package:tp_mobile_app/widgets/animations.dart';
import 'dart:developer' as developer;

import '../mailboxdetail.dart';

class ListOfMailboxes extends StatelessWidget {
  const ListOfMailboxes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<dynamic, dynamic> mailboxes = Database.getMailboxes();
    Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Zoznam schránok"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: (orientation == Orientation.landscape) ? 2 : 1,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: mailboxes.length,
                itemBuilder: (_, index) => ItemMailbox(
                  press: () => {
                    Navigator.of(context).push(
                        swipeRouteAnimation(MailboxDetail(
                            mailboxId: mailboxes.keys.firstWhere((k) => mailboxes[k] == mailboxes[index])
                        ))
                    ),
                  },
                  name: mailboxes[index],
                ),
              ),
            ),
          )
        ],
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
      splashColor: const Color.fromRGBO(194, 187, 33, 0.7019607843137254),
      onTap: press,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 220, 0, 0.7),
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
