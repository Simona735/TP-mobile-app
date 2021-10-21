import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:tp_mobile_app/screens/mailboxscreens/addmailbox.dart';
import 'package:tp_mobile_app/screens/mailboxscreens/mailboxlistpage.dart';
import 'package:tp_mobile_app/screens/mailboxscreens/profilepage.dart';
import 'package:tp_mobile_app/screens/mailboxscreens/settingspage.dart';
import 'package:tp_mobile_app/widgets/bottombar.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(
      path: '/',
      page: BottomBar,
      children: [
        AutoRoute(
          path: 'mailbox',
          name: 'MailboxRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: ListOfMailboxes),
          ],
        ),
        AutoRoute(
          path: 'settings',
          name: 'SettingsRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: SettingsPage),
          ],
        ),
        AutoRoute(
          path: 'addmailbox',
          name: 'AddMailboxRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: AddMailbox),
          ],
        ),
        AutoRoute(
          path: 'profilepage',
          name: 'ProfilePageRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: ProfilePage),
          ],
        ),
      ],
    ),
  ],
)
class $AppRouter {}
