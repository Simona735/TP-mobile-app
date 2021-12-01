import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tp_mobile_app/firebase/authentication.dart';
import 'package:tp_mobile_app/routes/router.gr.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"),
      ),
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
                    (Authentication.getDisplayName) ?? "Meno Priezvisko",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        AutoRouter.of(context).push(PasswordChangePageRoute());
                      },
                      child: const Text("Zmeniť heslo"),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5, left: 20, right: 20),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Authentication.signOut();
                        AutoRouter.of(context).replace(const LoginPageRoute());
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
