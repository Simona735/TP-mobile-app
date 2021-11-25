import 'package:flutter/material.dart';
import 'package:tp_mobile_app/routes/router.gr.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Mailbox',
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
