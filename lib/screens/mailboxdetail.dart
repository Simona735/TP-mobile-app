import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'dart:math' as math;

import 'package:tp_mobile_app/firebase/database.dart';

class MailboxDetail extends StatefulWidget {
  final mailboxId;

  const MailboxDetail({
    Key? key,
    @PathParam() required this.mailboxId,
  }) : super(key: key);

  @override
  State<MailboxDetail> createState() => _MailboxDetailState();
}

class _MailboxDetailState extends State<MailboxDetail> {
  double limit = 30;
  int listPercentage = 30;
  bool isSwitched = false;
  late Future<Map> mailboxData;

  @override
  initState() {
    super.initState();
    // TODO get all values
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Schránka 1"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Edit',
            onPressed: () { },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: CircularStepProgressIndicator(
                  totalSteps: limit.round(),
                  currentStep: listPercentage,
                  circularDirection: CircularDirection.counterclockwise,
                  stepSize: 5,
                  selectedColor:
                  listPercentage <= limit.round() ? Colors.yellow : Colors.red,
                  unselectedColor: Colors.grey[200],
                  padding: 0,
                  width: 150,
                  height: 150,
                  selectedStepSize: 15,
                  roundedCap: (_, __) => true,
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        (limit.round() < listPercentage) ? 'Full': listPercentage.toString() + "%",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ],
                  )),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Slider(
                value: limit,
                onChanged: (value) {
                  setState(() {
                    limit = value;
                  });
                },
                min: 1.0,
                max: 100.0,
                activeColor: Colors.yellow,
                inactiveColor: Colors.yellow[100],
                label: limit.round().toString(),
                divisions: 99,
              ),
              Text(
                "Limit: " + limit.round().toString() + "%",
                style: const TextStyle(fontSize: 20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: const Text("Low power mode",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Switch(
                    value: isSwitched,
                    onChanged: (value) => {
                      setState(
                        () {
                          isSwitched = value;
                        },
                      )
                    },
                  )
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
                                child: Icon(Icons.warning,
                                  size: 20,
                                  color: Colors.red,
                                ),
                              ),
                              TextSpan(
                                  text: " Reset schránky",
                                  style: TextStyle(color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  )
                              ),
                            ],
                          ),
                        ),
                        content: const Text('Nejaky popis toho co to je za reset a ci si je isty'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              //TODO Database.setReset(mailboxId);
                              Navigator.pop(context, 'OK');
                            },
                            child: const Text('OK',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      )
                  );
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
}
