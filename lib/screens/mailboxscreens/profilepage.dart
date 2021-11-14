import 'package:flutter/material.dart';
import 'package:tp_mobile_app/firebase/authentication.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.account_circle,
                    size: 200,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Authentication.getDisplayName,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 5, right: 5),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text("Zmeniť heslo"),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 5, right: 5),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Authentication.signOut();
                        //TODO go back to LoginPage()
                      },
                      child: const Text("Odhlásiť sa"),
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
