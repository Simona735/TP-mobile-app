import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tp_mobile_app/firebase/database.dart';
import 'package:tp_mobile_app/routes/router.gr.dart';
import 'package:tp_mobile_app/widgets/animations.dart';
import 'dart:developer' as developer;

import '../mailboxdetail.dart';

class ListOfMailboxes extends StatefulWidget {
  const ListOfMailboxes({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ListOfMailboxes();
}


class _ListOfMailboxes extends State<ListOfMailboxes> {
  late Future<Map> mailboxes;

  @override
  initState() {
    super.initState();
    mailboxes = Database.getMailboxes();
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Zoznam schránok"),
      ),
      body: FutureBuilder(
        future: mailboxes,
        initialData: 'Loading...',
        builder: (BuildContext context, AsyncSnapshot<Object> snapshot){
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error} occurred',
                  style: const TextStyle(fontSize: 18),
                ),
              );
            } else if (snapshot.hasData) {
              final data = snapshot.data as Map;
              return Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: GridView.builder(
                        padding: const EdgeInsets.all(10),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: (orientation == Orientation.landscape) ? 2 : 1,
                          childAspectRatio: 2,
                          mainAxisSpacing: (data.isNotEmpty) ? 10 : 0,
                          crossAxisSpacing: (data.isNotEmpty) ? 10 : 0,
                        ),
                        itemCount: data.length,
                        itemBuilder: (_, index) {
                          String key = data.keys.elementAt(index);
                          String value = data.values.elementAt(index);
                          return ItemMailbox(
                            press: () => {
                              Navigator.of(context).push(
                                  swipeRouteAnimation(MailboxDetail(
                                      mailboxId: key
                                  ))
                              ),
                            },
                            name: value,
                          );
                        }
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
        }
      )
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
