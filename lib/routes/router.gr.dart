// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i14;

import '../screens/authscreens/loginpage.dart' as _i2;
import '../screens/authscreens/passwordreset.dart' as _i4;
import '../screens/authscreens/registrationpage.dart' as _i3;
import '../screens/mailboxdetail.dart' as _i9;
import '../screens/mailboxscreens/addmailbox.dart' as _i11;
import '../screens/mailboxscreens/mailboxlistpage.dart' as _i8;
import '../screens/mailboxscreens/profilepage.dart' as _i12;
import '../screens/mailboxscreens/settingspage.dart' as _i10;
import '../screens/passwordchange.dart' as _i13;
import '../screens/pin/pinpage.dart' as _i5;
import '../screens/splash_screen.dart' as _i1;
import '../widgets/bottombar.dart' as _i6;

class AppRouter extends _i7.RootStackRouter {
  AppRouter([_i14.GlobalKey<_i14.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    SplashScreenRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.SplashScreen());
    },
    LoginPageRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: _i2.LoginPage());
    },
    RegistrationPageRoute.name: (routeData) {
      final args = routeData.argsAs<RegistrationPageRouteArgs>(
          orElse: () => const RegistrationPageRouteArgs());
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: _i3.RegistrationPage(key: args.key));
    },
    PasswordResetPageRoute.name: (routeData) {
      final args = routeData.argsAs<PasswordResetPageRouteArgs>(
          orElse: () => const PasswordResetPageRouteArgs());
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: _i4.PasswordResetPage(key: args.key));
    },
    PinPageRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.PinPage());
    },
    BottomBarRoute.name: (routeData) {
      final args = routeData.argsAs<BottomBarRouteArgs>(
          orElse: () => const BottomBarRouteArgs());
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: _i6.BottomBar(key: args.key));
    },
    MailboxRouter.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i7.EmptyRouterPage());
    },
    SettingsRouter.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i7.EmptyRouterPage());
    },
    AddMailboxRouter.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i7.EmptyRouterPage());
    },
    ProfilePageRouter.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i7.EmptyRouterPage());
    },
    ListOfMailboxesRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i8.ListOfMailboxes());
    },
    MailboxDetailRoute.name: (routeData) {
      final pathParams = routeData.pathParams;
      final args = routeData.argsAs<MailboxDetailRouteArgs>(
          orElse: () =>
              MailboxDetailRouteArgs(mailboxId: pathParams.get('mailboxId')));
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i9.MailboxDetail(key: args.key));
    },
    SettingsPageRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i10.SettingsPage());
    },
    AddMailboxRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i11.AddMailbox());
    },
    ProfilePageRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i12.ProfilePage());
    },
    PasswordChangePageRoute.name: (routeData) {
      final args = routeData.argsAs<PasswordChangePageRouteArgs>(
          orElse: () => const PasswordChangePageRouteArgs());
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: _i13.PasswordChangePage(key: args.key));
    }
  };

  @override
  List<_i7.RouteConfig> get routes => [
        _i7.RouteConfig(SplashScreenRoute.name, path: '/'),
        _i7.RouteConfig(LoginPageRoute.name, path: '/login'),
        _i7.RouteConfig(RegistrationPageRoute.name, path: '/registration'),
        _i7.RouteConfig(PasswordResetPageRoute.name, path: '/passwordreset'),
        _i7.RouteConfig(PinPageRoute.name, path: '/pin'),
        _i7.RouteConfig(BottomBarRoute.name, path: '/bottomBar', children: [
          _i7.RouteConfig(MailboxRouter.name, path: 'mailbox', children: [
            _i7.RouteConfig(ListOfMailboxesRoute.name, path: ''),
            _i7.RouteConfig(MailboxDetailRoute.name, path: ':mailboxId')
          ]),
          _i7.RouteConfig(SettingsRouter.name,
              path: 'settings',
              children: [_i7.RouteConfig(SettingsPageRoute.name, path: '')]),
          _i7.RouteConfig(AddMailboxRouter.name,
              path: 'addmailbox',
              children: [_i7.RouteConfig(AddMailboxRoute.name, path: '')]),
          _i7.RouteConfig(ProfilePageRouter.name,
              path: 'profilepage',
              children: [
                _i7.RouteConfig(ProfilePageRoute.name, path: ''),
                _i7.RouteConfig(PasswordChangePageRoute.name,
                    path: 'passwordchange')
              ])
        ])
      ];
}

/// generated route for [_i1.SplashScreen]
class SplashScreenRoute extends _i7.PageRouteInfo<void> {
  const SplashScreenRoute() : super(name, path: '/');

  static const String name = 'SplashScreenRoute';
}

/// generated route for [_i2.LoginPage]
class LoginPageRoute extends _i7.PageRouteInfo<void> {
  const LoginPageRoute() : super(name, path: '/login');

  static const String name = 'LoginPageRoute';
}

/// generated route for [_i3.RegistrationPage]
class RegistrationPageRoute
    extends _i7.PageRouteInfo<RegistrationPageRouteArgs> {
  RegistrationPageRoute({_i14.Key? key})
      : super(name,
            path: '/registration', args: RegistrationPageRouteArgs(key: key));

  static const String name = 'RegistrationPageRoute';
}

class RegistrationPageRouteArgs {
  const RegistrationPageRouteArgs({this.key});

  final _i14.Key? key;
}

/// generated route for [_i4.PasswordResetPage]
class PasswordResetPageRoute
    extends _i7.PageRouteInfo<PasswordResetPageRouteArgs> {
  PasswordResetPageRoute({_i14.Key? key})
      : super(name,
            path: '/passwordreset', args: PasswordResetPageRouteArgs(key: key));

  static const String name = 'PasswordResetPageRoute';
}

class PasswordResetPageRouteArgs {
  const PasswordResetPageRouteArgs({this.key});

  final _i14.Key? key;
}

/// generated route for [_i5.PinPage]
class PinPageRoute extends _i7.PageRouteInfo<void> {
  const PinPageRoute() : super(name, path: '/pin');

  static const String name = 'PinPageRoute';
}

/// generated route for [_i6.BottomBar]
class BottomBarRoute extends _i7.PageRouteInfo<BottomBarRouteArgs> {
  BottomBarRoute({_i14.Key? key, List<_i7.PageRouteInfo>? children})
      : super(name,
            path: '/bottomBar',
            args: BottomBarRouteArgs(key: key),
            initialChildren: children);

  static const String name = 'BottomBarRoute';
}

class BottomBarRouteArgs {
  const BottomBarRouteArgs({this.key});

  final _i14.Key? key;
}

/// generated route for [_i7.EmptyRouterPage]
class MailboxRouter extends _i7.PageRouteInfo<void> {
  const MailboxRouter({List<_i7.PageRouteInfo>? children})
      : super(name, path: 'mailbox', initialChildren: children);

  static const String name = 'MailboxRouter';
}

/// generated route for [_i7.EmptyRouterPage]
class SettingsRouter extends _i7.PageRouteInfo<void> {
  const SettingsRouter({List<_i7.PageRouteInfo>? children})
      : super(name, path: 'settings', initialChildren: children);

  static const String name = 'SettingsRouter';
}

/// generated route for [_i7.EmptyRouterPage]
class AddMailboxRouter extends _i7.PageRouteInfo<void> {
  const AddMailboxRouter({List<_i7.PageRouteInfo>? children})
      : super(name, path: 'addmailbox', initialChildren: children);

  static const String name = 'AddMailboxRouter';
}

/// generated route for [_i7.EmptyRouterPage]
class ProfilePageRouter extends _i7.PageRouteInfo<void> {
  const ProfilePageRouter({List<_i7.PageRouteInfo>? children})
      : super(name, path: 'profilepage', initialChildren: children);

  static const String name = 'ProfilePageRouter';
}

/// generated route for [_i8.ListOfMailboxes]
class ListOfMailboxesRoute extends _i7.PageRouteInfo<void> {
  const ListOfMailboxesRoute() : super(name, path: '');

  static const String name = 'ListOfMailboxesRoute';
}

/// generated route for [_i9.MailboxDetail]
class MailboxDetailRoute extends _i7.PageRouteInfo<MailboxDetailRouteArgs> {
  MailboxDetailRoute({_i14.Key? key, required dynamic mailboxId})
      : super(name,
            path: ':mailboxId',
            args: MailboxDetailRouteArgs(key: key, mailboxId: mailboxId),
            rawPathParams: {'mailboxId': mailboxId});

  static const String name = 'MailboxDetailRoute';
}

class MailboxDetailRouteArgs {
  const MailboxDetailRouteArgs({this.key, required this.mailboxId});

  final _i14.Key? key;

  final dynamic mailboxId;
}

/// generated route for [_i10.SettingsPage]
class SettingsPageRoute extends _i7.PageRouteInfo<void> {
  const SettingsPageRoute() : super(name, path: '');

  static const String name = 'SettingsPageRoute';
}

/// generated route for [_i11.AddMailbox]
class AddMailboxRoute extends _i7.PageRouteInfo<void> {
  const AddMailboxRoute() : super(name, path: '');

  static const String name = 'AddMailboxRoute';
}

/// generated route for [_i12.ProfilePage]
class ProfilePageRoute extends _i7.PageRouteInfo<void> {
  const ProfilePageRoute() : super(name, path: '');

  static const String name = 'ProfilePageRoute';
}

/// generated route for [_i13.PasswordChangePage]
class PasswordChangePageRoute
    extends _i7.PageRouteInfo<PasswordChangePageRouteArgs> {
  PasswordChangePageRoute({_i14.Key? key})
      : super(name,
            path: 'passwordchange',
            args: PasswordChangePageRouteArgs(key: key));

  static const String name = 'PasswordChangePageRoute';
}

class PasswordChangePageRouteArgs {
  const PasswordChangePageRouteArgs({this.key});

  final _i14.Key? key;
}
