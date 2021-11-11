import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'dart:math' as math;

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
  double limit = 5;
  int listCount = 3;
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: CircularStepProgressIndicator(
                totalSteps: limit.round(),
                currentStep: listCount,
                stepSize: 5,
                selectedColor:
                    listCount <= limit.round() ? Colors.yellow : Colors.red,
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
                      listCount.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ],
                )),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
