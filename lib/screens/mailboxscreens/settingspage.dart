import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    bool isSwitched = false;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nastavenia"),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Biometrické prihlásenie"),
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
          ),
        ],
      ),
    );
  }
}
