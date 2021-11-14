// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i11;

import '../screens/authscreens/loginpage.dart' as _i2;
import '../screens/authscreens/registrationpage.dart' as _i3;
import '../screens/mailboxdetail.dart' as _i7;
import '../screens/mailboxscreens/addmailbox.dart' as _i9;
import '../screens/mailboxscreens/mailboxlistpage.dart' as _i6;
import '../screens/mailboxscreens/profilepage.dart' as _i10;
import '../screens/mailboxscreens/settingspage.dart' as _i8;
import '../screens/splash_screen.dart' as _i1;
import '../widgets/bottombar.dart' as _i4;

class AppRouter extends _i5.RootStackRouter {
  AppRouter([_i11.GlobalKey<_i11.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    SplashScreenRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.SplashScreen());
    },
    LoginPageRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.LoginPage());
    },
    RegistrationPageRoute.name: (routeData) {
      final args = routeData.argsAs<RegistrationPageRouteArgs>(
          orElse: () => const RegistrationPageRouteArgs());
      return _i5.MaterialPageX<dynamic>(
          routeData: routeData, child: _i3.RegistrationPage(key: args.key));
    },
    BottomBarRoute.name: (routeData) {
      final args = routeData.argsAs<BottomBarRouteArgs>(
          orElse: () => const BottomBarRouteArgs());
      return _i5.MaterialPageX<dynamic>(
          routeData: routeData, child: _i4.BottomBar(key: args.key));
    },
    MailboxRouter.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.EmptyRouterPage());
    },
    SettingsRouter.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.EmptyRouterPage());
    },
    AddMailboxRouter.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.EmptyRouterPage());
    },
    ProfilePageRouter.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.EmptyRouterPage());
    },
    ListOfMailboxesRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.ListOfMailboxes());
    },
    MailboxDetailRoute.name: (routeData) {
      final pathParams = routeData.pathParams;
      final args = routeData.argsAs<MailboxDetailRouteArgs>(
          orElse: () =>
              MailboxDetailRouteArgs(mailboxId: pathParams.get('mailboxId')));
      return _i5.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i7.MailboxDetail(key: args.key, mailboxId: args.mailboxId));
    },
    SettingsPageRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i8.SettingsPage());
    },
    AddMailboxRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i9.AddMailbox());
    },
    ProfilePageRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i10.ProfilePage());
    }
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig(SplashScreenRoute.name, path: '/'),
        _i5.RouteConfig(LoginPageRoute.name, path: '/login'),
        _i5.RouteConfig(RegistrationPageRoute.name, path: '/registration'),
        _i5.RouteConfig(BottomBarRoute.name, path: '/bottomBar', children: [
          _i5.RouteConfig(MailboxRouter.name, path: 'mailbox', children: [
            _i5.RouteConfig(ListOfMailboxesRoute.name, path: ''),
            _i5.RouteConfig(MailboxDetailRoute.name, path: ':mailboxId')
          ]),
          _i5.RouteConfig(SettingsRouter.name,
              path: 'settings',
              children: [_i5.RouteConfig(SettingsPageRoute.name, path: '')]),
          _i5.RouteConfig(AddMailboxRouter.name,
              path: 'addmailbox',
              children: [_i5.RouteConfig(AddMailboxRoute.name, path: '')]),
          _i5.RouteConfig(ProfilePageRouter.name,
              path: 'profilepage',
              children: [_i5.RouteConfig(ProfilePageRoute.name, path: '')])
        ])
      ];
}

/// generated route for [_i1.SplashScreen]
class SplashScreenRoute extends _i5.PageRouteInfo<void> {
  const SplashScreenRoute() : super(name, path: '/');

  static const String name = 'SplashScreenRoute';
}

/// generated route for [_i2.LoginPage]
class LoginPageRoute extends _i5.PageRouteInfo<void> {
  const LoginPageRoute() : super(name, path: '/login');

  static const String name = 'LoginPageRoute';
}

/// generated route for [_i3.RegistrationPage]
class RegistrationPageRoute
    extends _i5.PageRouteInfo<RegistrationPageRouteArgs> {
  RegistrationPageRoute({_i11.Key? key})
      : super(name,
            path: '/registration', args: RegistrationPageRouteArgs(key: key));

  static const String name = 'RegistrationPageRoute';
}

class RegistrationPageRouteArgs {
  const RegistrationPageRouteArgs({this.key});

  final _i11.Key? key;
}

/// generated route for [_i4.BottomBar]
class BottomBarRoute extends _i5.PageRouteInfo<BottomBarRouteArgs> {
  BottomBarRoute({_i11.Key? key, List<_i5.PageRouteInfo>? children})
      : super(name,
            path: '/bottomBar',
            args: BottomBarRouteArgs(key: key),
            initialChildren: children);

  static const String name = 'BottomBarRoute';
}

class BottomBarRouteArgs {
  const BottomBarRouteArgs({this.key});

  final _i11.Key? key;
}

/// generated route for [_i5.EmptyRouterPage]
class MailboxRouter extends _i5.PageRouteInfo<void> {
  const MailboxRouter({List<_i5.PageRouteInfo>? children})
      : super(name, path: 'mailbox', initialChildren: children);

  static const String name = 'MailboxRouter';
}

/// generated route for [_i5.EmptyRouterPage]
class SettingsRouter extends _i5.PageRouteInfo<void> {
  const SettingsRouter({List<_i5.PageRouteInfo>? children})
      : super(name, path: 'settings', initialChildren: children);

  static const String name = 'SettingsRouter';
}

/// generated route for [_i5.EmptyRouterPage]
class AddMailboxRouter extends _i5.PageRouteInfo<void> {
  const AddMailboxRouter({List<_i5.PageRouteInfo>? children})
      : super(name, path: 'addmailbox', initialChildren: children);

  static const String name = 'AddMailboxRouter';
}

/// generated route for [_i5.EmptyRouterPage]
class ProfilePageRouter extends _i5.PageRouteInfo<void> {
  const ProfilePageRouter({List<_i5.PageRouteInfo>? children})
      : super(name, path: 'profilepage', initialChildren: children);

  static const String name = 'ProfilePageRouter';
}

/// generated route for [_i6.ListOfMailboxes]
class ListOfMailboxesRoute extends _i5.PageRouteInfo<void> {
  const ListOfMailboxesRoute() : super(name, path: '');

  static const String name = 'ListOfMailboxesRoute';
}

/// generated route for [_i7.MailboxDetail]
class MailboxDetailRoute extends _i5.PageRouteInfo<MailboxDetailRouteArgs> {
  MailboxDetailRoute({_i11.Key? key, required dynamic mailboxId})
      : super(name,
            path: ':mailboxId',
            args: MailboxDetailRouteArgs(key: key, mailboxId: mailboxId),
            rawPathParams: {'mailboxId': mailboxId});

  static const String name = 'MailboxDetailRoute';
}

class MailboxDetailRouteArgs {
  const MailboxDetailRouteArgs({this.key, required this.mailboxId});

  final _i11.Key? key;

  final dynamic mailboxId;
}

/// generated route for [_i8.SettingsPage]
class SettingsPageRoute extends _i5.PageRouteInfo<void> {
  const SettingsPageRoute() : super(name, path: '');

  static const String name = 'SettingsPageRoute';
}

/// generated route for [_i9.AddMailbox]
class AddMailboxRoute extends _i5.PageRouteInfo<void> {
  const AddMailboxRoute() : super(name, path: '');

  static const String name = 'AddMailboxRoute';
}

/// generated route for [_i10.ProfilePage]
class ProfilePageRoute extends _i5.PageRouteInfo<void> {
  const ProfilePageRoute() : super(name, path: '');

  static const String name = 'ProfilePageRoute';
}
