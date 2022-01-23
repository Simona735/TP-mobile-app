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
    return AutoTabsScaffold(
      routes: const [
        MailboxRouter(),
        SettingsRouter(),
        ProfilePageRouter(),
        AddMailboxRouter()
      ],
      builder: (context, child, animation) {
        return Scaffold(
          body: ScaleTransition(
            scale: Tween<double>(
              begin: 1.0,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.fastOutSlowIn,
              ),
            ),
            child: child,
          ),
        );
      },
      bottomNavigationBuilder: (_, tabsRouter) => SalomonBottomBar(
        selectedItemColor: Theme.of(context).bottomAppBarColor,
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        currentIndex: tabsRouter.activeIndex,
        onTap: (index) {
          tabsRouter.stackRouterOfIndex(index)?.popUntilRoot();
          tabsRouter.setActiveIndex(index);
        },
        items: [
          SalomonBottomBarItem(
            icon: const Icon(
              Icons.mail,
              size: 30,
            ),
            title: const Text('Schránky'),
          ),
          SalomonBottomBarItem(
            icon: const Icon(
              Icons.settings_outlined,
              size: 30,
            ),
            title: const Text('Nastavenia'),
          ),
          SalomonBottomBarItem(
            icon: const Icon(
              Icons.person,
              size: 30,
            ),
            title: const Text('Profil'),
          ),
          SalomonBottomBarItem(
            icon: const Icon(
              Icons.add,
              size: 30,
            ),
            title: const Text('Pridať'),
          ),
        ],
      ),
    );
  }
}
