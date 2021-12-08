import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:tp_mobile_app/screens/pin/pinpageview.dart';

class PinPage extends StatelessWidget {
  const PinPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        const app = Scaffold(
          body: PinPutView()
        );
        if (constraints.maxWidth > 600 && constraints.maxHeight > 600) {
          return Container(
            color: Colors.white,
            alignment: Alignment.center,
            child: AspectRatio(
              aspectRatio: .5,
              child: Container(
                margin: EdgeInsets.all(20),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 20,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: app,
              ),
            ),
          );
        }
        return app;
      },
    );
  }
}
