import 'package:flutter/material.dart';

class ListOfMailboxes extends StatelessWidget {
  const ListOfMailboxes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                itemCount: 20,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (context, index) => Container(),
              ),
            ),
          )
        ],
      ),
    );
  }
}

