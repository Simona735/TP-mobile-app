import 'package:flutter/material.dart';

class AddMailbox extends StatelessWidget {
  const AddMailbox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pridanie schránky"),
      ),
    );
  }
}
