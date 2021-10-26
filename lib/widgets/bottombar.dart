import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:tp_mobile_app/routes/router.gr.dart';

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
              begin: 0.0,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                parent: animation,
                // curve: Curves.easeInQuint,
                curve: Curves.slowMiddle,
              ),
            ),
            child: child,
          ),
        );
      },
      bottomNavigationBuilder: (_, tabsRouter) => SalomonBottomBar(
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        currentIndex: tabsRouter.activeIndex,
        onTap: tabsRouter.setActiveIndex,
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