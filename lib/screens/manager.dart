import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:tp_mobile_app/bindings/bottom_bar_binding.dart';
import 'package:tp_mobile_app/routes/router.gr.dart';
import 'package:tp_mobile_app/screens/authscreens/loginpage.dart';
import 'package:tp_mobile_app/screens/authscreens/passwordreset.dart';
import 'package:tp_mobile_app/screens/authscreens/registrationpage.dart';
import 'package:tp_mobile_app/screens/mailboxscreens/settingspage.dart';
import 'package:tp_mobile_app/screens/pin/pinpage.dart';
import 'package:tp_mobile_app/screens/splash_screen.dart';
import 'package:tp_mobile_app/widgets/bottombar.dart';
import 'package:tp_mobile_app/widgets/customtheme.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mailbox',
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeMode.system,
      initialRoute: '/',
      getPages: [
        GetPage(name: "/", page: () => const SplashScreen()),
        GetPage(name: "/pin", page: () => const PinPage()),
        GetPage(name: "/login", page: () => LoginPage()),
        GetPage(name: "/bottomBar", page: () => BottomBar(), binding: BottomBarBinding()),
        GetPage(name: "/settings", page: () => const SettingsPage()),
        GetPage(name: "/registration", page: () => RegistrationPage()),
        GetPage(name: "/resetPassword", page: () => PasswordResetPage())
      ],
      // routerDelegate: _appRouter.delegate(),
      // routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
