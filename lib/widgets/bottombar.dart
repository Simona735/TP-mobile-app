import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:tp_mobile_app/controllers/bottom_bar_controller.dart';
import 'package:tp_mobile_app/routes/router.gr.dart';
import 'package:tp_mobile_app/screens/mailboxscreens/addmailbox.dart';
import 'package:tp_mobile_app/screens/mailboxscreens/mailboxlistpage.dart';
import 'package:tp_mobile_app/screens/mailboxscreens/profilepage.dart';
import 'package:tp_mobile_app/screens/mailboxscreens/settingspage.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    // final controller = Get.find<BottomBarController>();
    final controller = Get.put(BottomBarController());
    return Scaffold(
        body: SizedBox.expand(
          child: PageView(
            controller: controller.pageController,
            onPageChanged: (index) {
              controller.updateIndex(index);
            },
            children: const [
              ListOfMailboxes(),
              SettingsPage(),
              ProfilePage(),
              AddMailbox()
            ],
          ),
        ),
        // body: Obx(() =>
        //   IndexedStack(
        //     index: controller.index.value,
        //     children: const [
        //       ListOfMailboxes(),
        //       SettingsPage(),
        //       ProfilePage(),
        //       AddMailbox()
        //     ],
        //   ),
        // ),
        bottomNavigationBar: Obx(
          () => SalomonBottomBar(
            selectedItemColor: Theme.of(context).bottomAppBarColor,
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 5,
            ),
            currentIndex: controller.index.value,
            onTap: (index) {
              controller.updateIndex(index);
              controller.pageController.jumpToPage(controller.index.value);
            },
            items: [
              SalomonBottomBarItem(
                icon: Icon(
                  Icons.mail,
                  size: (orientation == Orientation.landscape) ? 20 : 25,
                ),
                title: const Text('Schránky'),
              ),
              SalomonBottomBarItem(
                icon: Icon(
                  Icons.settings_outlined,
                  size: (orientation == Orientation.landscape) ? 20 : 25,
                ),
                title: const Text('Nastavenia'),
              ),
              SalomonBottomBarItem(
                icon: Icon(
                  Icons.person,
                  size: (orientation == Orientation.landscape) ? 20 : 25,
                ),
                title: const Text('Profil'),
              ),
              SalomonBottomBarItem(
                icon: Icon(
                  Icons.add,
                  size: (orientation == Orientation.landscape) ? 20 : 25,
                ),
                title: const Text('Pridať'),
              ),
            ],
          ),
        ));
  }
}
