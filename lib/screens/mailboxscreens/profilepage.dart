import 'package:auto_route/auto_route.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tp_mobile_app/controllers/settings_controller.dart';
import 'package:tp_mobile_app/firebase/authentication.dart';
import 'package:tp_mobile_app/routes/router.gr.dart';
import 'package:tp_mobile_app/screens/authscreens/loginpage.dart';
import 'package:tp_mobile_app/screens/passwordchange.dart';
import 'package:tp_mobile_app/widgets/animations.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    final settingsController = Get.find<SettingsController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"),
      ),
      body: (orientation == Orientation.portrait) ? Column(
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
                        Get.to(() => const PasswordChangePage(), transition: Transition.leftToRight);
                        // Navigator.of(context).push(swipeRouteAnimation(PasswordChangePage()));
                        // AutoRouter.of(context).push(PasswordChangePageRoute());
                      },
                      child: const Text("Zmeniť heslo"),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5, left: 20, right: 20),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        Authentication.signOut();
                        settingsController.deletePin();
                        // settingsController.saveSwitchState("switchState", false);
                        Get.offAll(() => LoginPage());
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
      ) : Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10, right: 20),
                child: const Icon(
                  Icons.account_circle,
                  size: 120,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10, right: 20),
                child: Text(
                  (Authentication.getDisplayName) ?? "Meno Priezvisko",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => const PasswordChangePage(), transition: Transition.leftToRight);
                    // Navigator.of(context).push(swipeRouteAnimation(PasswordChangePage()));
                    // AutoRouter.of(context).push(PasswordChangePageRoute());
                  },
                  child: const Text("Zmeniť heslo"),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
                width: 300,
                child: ElevatedButton(
                  onPressed: () async {
                    Authentication.signOut();
                    settingsController.deletePin();
                    // settingsController.saveSwitchState("switchState", false);
                    Get.offAll(() => LoginPage());
                  },
                  child: const Text("Odhlásiť sa"),
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                ),
              ),
            ],
          ),
        ],
      )
    );
  }
}
