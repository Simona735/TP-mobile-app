// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i2;
import 'package:flutter/material.dart' as _i7;

import '../screens/mailboxscreens/addmailbox.dart' as _i5;
import '../screens/mailboxscreens/mailboxlistpage.dart' as _i3;
import '../screens/mailboxscreens/profilepage.dart' as _i6;
import '../screens/mailboxscreens/settingspage.dart' as _i4;
import '../widgets/bottombar.dart' as _i1;

class AppRouter extends _i2.RootStackRouter {
  AppRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    BottomBarRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.BottomBar());
    },
    MailboxRouter.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.EmptyRouterPage());
    },
    SettingsRouter.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.EmptyRouterPage());
    },
    AddMailboxRouter.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.EmptyRouterPage());
    },
    ProfilePageRouter.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.EmptyRouterPage());
    },
    ListOfMailboxesRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.ListOfMailboxes());
    },
    SettingsPageRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.SettingsPage());
    },
    AddMailboxRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.AddMailbox());
    },
    ProfilePageRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.ProfilePage());
    }
  };

  @override
  List<_i2.RouteConfig> get routes => [
        _i2.RouteConfig(BottomBarRoute.name, path: '/', children: [
          _i2.RouteConfig(MailboxRouter.name,
              path: 'mailbox',
              children: [_i2.RouteConfig(ListOfMailboxesRoute.name, path: '')]),
          _i2.RouteConfig(SettingsRouter.name,
              path: 'settings',
              children: [_i2.RouteConfig(SettingsPageRoute.name, path: '')]),
          _i2.RouteConfig(AddMailboxRouter.name,
              path: 'addmailbox',
              children: [_i2.RouteConfig(AddMailboxRoute.name, path: '')]),
          _i2.RouteConfig(ProfilePageRouter.name,
              path: 'profilepage',
              children: [_i2.RouteConfig(ProfilePageRoute.name, path: '')])
        ])
      ];
}

/// generated route for [_i1.BottomBar]
class BottomBarRoute extends _i2.PageRouteInfo<void> {
  const BottomBarRoute({List<_i2.PageRouteInfo>? children})
      : super(name, path: '/', initialChildren: children);

  static const String name = 'BottomBarRoute';
}

/// generated route for [_i2.EmptyRouterPage]
class MailboxRouter extends _i2.PageRouteInfo<void> {
  const MailboxRouter({List<_i2.PageRouteInfo>? children})
      : super(name, path: 'mailbox', initialChildren: children);

  static const String name = 'MailboxRouter';
}

/// generated route for [_i2.EmptyRouterPage]
class SettingsRouter extends _i2.PageRouteInfo<void> {
  const SettingsRouter({List<_i2.PageRouteInfo>? children})
      : super(name, path: 'settings', initialChildren: children);

  static const String name = 'SettingsRouter';
}

/// generated route for [_i2.EmptyRouterPage]
class AddMailboxRouter extends _i2.PageRouteInfo<void> {
  const AddMailboxRouter({List<_i2.PageRouteInfo>? children})
      : super(name, path: 'addmailbox', initialChildren: children);

  static const String name = 'AddMailboxRouter';
}

/// generated route for [_i2.EmptyRouterPage]
class ProfilePageRouter extends _i2.PageRouteInfo<void> {
  const ProfilePageRouter({List<_i2.PageRouteInfo>? children})
      : super(name, path: 'profilepage', initialChildren: children);

  static const String name = 'ProfilePageRouter';
}

/// generated route for [_i3.ListOfMailboxes]
class ListOfMailboxesRoute extends _i2.PageRouteInfo<void> {
  const ListOfMailboxesRoute() : super(name, path: '');

  static const String name = 'ListOfMailboxesRoute';
}

/// generated route for [_i4.SettingsPage]
class SettingsPageRoute extends _i2.PageRouteInfo<void> {
  const SettingsPageRoute() : super(name, path: '');

  static const String name = 'SettingsPageRoute';
}

/// generated route for [_i5.AddMailbox]
class AddMailboxRoute extends _i2.PageRouteInfo<void> {
  const AddMailboxRoute() : super(name, path: '');

  static const String name = 'AddMailboxRoute';
}

/// generated route for [_i6.ProfilePage]
class ProfilePageRoute extends _i2.PageRouteInfo<void> {
  const ProfilePageRoute() : super(name, path: '');

  static const String name = 'ProfilePageRoute';
}
