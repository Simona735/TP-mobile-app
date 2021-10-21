import 'package:flutter/material.dart';

class ListOfMailboxes extends StatelessWidget {
  const ListOfMailboxes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Zoznam schránok"),
      ),
    );
  }
}
