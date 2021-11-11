// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i2;
import 'package:flutter/material.dart' as _i8;

import '../screens/mailboxdetail.dart' as _i4;
import '../screens/mailboxscreens/addmailbox.dart' as _i6;
import '../screens/mailboxscreens/mailboxlistpage.dart' as _i3;
import '../screens/mailboxscreens/profilepage.dart' as _i7;
import '../screens/mailboxscreens/settingspage.dart' as _i5;
import '../widgets/bottombar.dart' as _i1;

class AppRouter extends _i2.RootStackRouter {
  AppRouter([_i8.GlobalKey<_i8.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    BottomBarRoute.name: (routeData) {
      final args = routeData.argsAs<BottomBarRouteArgs>(
          orElse: () => const BottomBarRouteArgs());
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: _i1.BottomBar(key: args.key));
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
    MailboxDetailRoute.name: (routeData) {
      final pathParams = routeData.pathParams;
      final args = routeData.argsAs<MailboxDetailRouteArgs>(
          orElse: () =>
              MailboxDetailRouteArgs(mailboxId: pathParams.get('mailboxId')));
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i4.MailboxDetail(key: args.key, mailboxId: args.mailboxId));
    },
    SettingsPageRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.SettingsPage());
    },
    AddMailboxRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.AddMailbox());
    },
    ProfilePageRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i7.ProfilePage());
    }
  };

  @override
  List<_i2.RouteConfig> get routes => [
        _i2.RouteConfig(BottomBarRoute.name, path: '/', children: [
          _i2.RouteConfig(MailboxRouter.name, path: 'mailbox', children: [
            _i2.RouteConfig(ListOfMailboxesRoute.name, path: ''),
            _i2.RouteConfig(MailboxDetailRoute.name, path: ':mailboxId')
          ]),
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
class BottomBarRoute extends _i2.PageRouteInfo<BottomBarRouteArgs> {
  BottomBarRoute({_i8.Key? key, List<_i2.PageRouteInfo>? children})
      : super(name,
            path: '/',
            args: BottomBarRouteArgs(key: key),
            initialChildren: children);

  static const String name = 'BottomBarRoute';
}

class BottomBarRouteArgs {
  const BottomBarRouteArgs({this.key});

  final _i8.Key? key;
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

/// generated route for [_i4.MailboxDetail]
class MailboxDetailRoute extends _i2.PageRouteInfo<MailboxDetailRouteArgs> {
  MailboxDetailRoute({_i8.Key? key, required dynamic mailboxId})
      : super(name,
            path: ':mailboxId',
            args: MailboxDetailRouteArgs(key: key, mailboxId: mailboxId),
            rawPathParams: {'mailboxId': mailboxId});

  static const String name = 'MailboxDetailRoute';
}

class MailboxDetailRouteArgs {
  const MailboxDetailRouteArgs({this.key, required this.mailboxId});

  final _i8.Key? key;

  final dynamic mailboxId;
}

/// generated route for [_i5.SettingsPage]
class SettingsPageRoute extends _i2.PageRouteInfo<void> {
  const SettingsPageRoute() : super(name, path: '');

  static const String name = 'SettingsPageRoute';
}

/// generated route for [_i6.AddMailbox]
class AddMailboxRoute extends _i2.PageRouteInfo<void> {
  const AddMailboxRoute() : super(name, path: '');

  static const String name = 'AddMailboxRoute';
}

/// generated route for [_i7.ProfilePage]
class ProfilePageRoute extends _i2.PageRouteInfo<void> {
  const ProfilePageRoute() : super(name, path: '');

  static const String name = 'ProfilePageRoute';
}
