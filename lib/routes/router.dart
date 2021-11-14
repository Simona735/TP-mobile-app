import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:tp_mobile_app/screens/authscreens/loginpage.dart';
import 'package:tp_mobile_app/screens/authscreens/registrationpage.dart';
import 'package:tp_mobile_app/screens/mailboxdetail.dart';
import 'package:tp_mobile_app/screens/mailboxscreens/addmailbox.dart';
import 'package:tp_mobile_app/screens/mailboxscreens/mailboxlistpage.dart';
import 'package:tp_mobile_app/screens/mailboxscreens/profilepage.dart';
import 'package:tp_mobile_app/screens/mailboxscreens/settingspage.dart';
import 'package:tp_mobile_app/screens/splash_screen.dart';
import 'package:tp_mobile_app/widgets/bottombar.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(
      path: '/',
      page: SplashScreen
    ),
    AutoRoute(
      path: '/login',
      page: LoginPage
    ),
    AutoRoute(
      path: '/registration',
      page: RegistrationPage
    ),
    AutoRoute(
      path: '/bottomBar',
      page: BottomBar,
      children: [
        AutoRoute(
          path: 'mailbox',
          name: 'MailboxRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: ListOfMailboxes),
            AutoRoute(path: ':mailboxId', page: MailboxDetail),
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
