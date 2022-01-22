import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'dart:math' as math;

import 'package:tp_mobile_app/firebase/database.dart';

class MailboxDetail extends StatelessWidget {
  const MailboxDetail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      FutureBuilder(
        future: mailboxData,
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
              return Scaffold(
              appBar: AppBar(
                title: Text(data['name']),
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.edit),
                    tooltip: 'Edit',
                    onPressed: () {
                      titleController.text = data['name'];
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Edituj názov'),
                          content: TextField(
                            controller: titleController,
                            // decoration: InputDecoration(hintText: "Text Field in Dialog"),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                Database.updateTitle(widget.mailboxId, titleController.text);
                                setState(() {
                                  data['name'] = titleController.text;
                                });
                                Navigator.pop(context, 'OK');
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        )
                      );
                    },
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
                          totalSteps: data['limit'].round(),
                          currentStep: listPercentage,
                          circularDirection: CircularDirection.counterclockwise,
                          stepSize: 5,
                          selectedColor:
                          listPercentage <= data['limit'].round() ? Colors.yellow : Colors.red,
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
                                (data['limit'].round() < listPercentage) ? 'Full': listPercentage.toString() + "%",
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
                        value: 1.0 * data['limit'],
                        onChanged: (value) {
                          setState(() {
                            data['limit'] = value;
                          });
                        },
                        onChangeEnd: (value){
                          setState(() {
                            data['limit'] = value;
                            Database.updateLimit(widget.mailboxId, data['limit'].toInt());
                          });
                        },
                        min: 1.0,
                        max: 100.0,
                        activeColor: Colors.yellow,
                        inactiveColor: Colors.yellow[100],
                        label: data['limit'].round().toString(),
                        divisions: 99,
                      ),
                      Text(
                        "Limit: " + data['limit'].round().toString() + "%",
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
                            value: data['low_power'],
                            onChanged: (value) => {
                              setState(
                                () {
                                  data['low_power'] = value;
                                  Database.updateLowPower(widget.mailboxId, value);
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
                                    Database.setReset(widget.mailboxId);
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
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      );
  }
}
