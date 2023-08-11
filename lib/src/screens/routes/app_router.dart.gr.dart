// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:placex/src/screens/ExploreScreen.dart' as _i1;
import 'package:placex/src/screens/HomeScreen.dart' as _i2;
import 'package:placex/src/screens/JoinScreen.dart' as _i3;
import 'package:placex/src/screens/LoginScreen.dart' as _i5;
import 'package:placex/src/screens/NoticeDetailscreen.dart' as _i6;
import 'package:placex/src/screens/NoticeScreen.dart' as _i7;
import 'package:placex/src/screens/ProfileScreen.dart' as _i8;
import 'package:placex/src/screens/routes/ladingScreen.dart' as _i4;

abstract class $AppRouter extends _i9.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    ExploreRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.ExploreScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomeScreen(),
      );
    },
    JoinRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.JoinScreen(),
      );
    },
    LandingRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.LandingScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.LoginScreen(),
      );
    },
    NoticeDetailRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.NoticeDetailScreen(),
      );
    },
    NoticeRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.NoticeScreen(),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.ProfileScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.ExploreScreen]
class ExploreRoute extends _i9.PageRouteInfo<void> {
  const ExploreRoute({List<_i9.PageRouteInfo>? children})
      : super(
          ExploreRoute.name,
          initialChildren: children,
        );

  static const String name = 'ExploreRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i2.HomeScreen]
class HomeRoute extends _i9.PageRouteInfo<void> {
  const HomeRoute({List<_i9.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i3.JoinScreen]
class JoinRoute extends _i9.PageRouteInfo<void> {
  const JoinRoute({List<_i9.PageRouteInfo>? children})
      : super(
          JoinRoute.name,
          initialChildren: children,
        );

  static const String name = 'JoinRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i4.LandingScreen]
class LandingRoute extends _i9.PageRouteInfo<void> {
  const LandingRoute({List<_i9.PageRouteInfo>? children})
      : super(
          LandingRoute.name,
          initialChildren: children,
        );

  static const String name = 'LandingRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i5.LoginScreen]
class LoginRoute extends _i9.PageRouteInfo<void> {
  const LoginRoute({List<_i9.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i6.NoticeDetailScreen]
class NoticeDetailRoute extends _i9.PageRouteInfo<void> {
  const NoticeDetailRoute({List<_i9.PageRouteInfo>? children})
      : super(
          NoticeDetailRoute.name,
          initialChildren: children,
        );

  static const String name = 'NoticeDetailRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i7.NoticeScreen]
class NoticeRoute extends _i9.PageRouteInfo<void> {
  const NoticeRoute({List<_i9.PageRouteInfo>? children})
      : super(
          NoticeRoute.name,
          initialChildren: children,
        );

  static const String name = 'NoticeRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i8.ProfileScreen]
class ProfileRoute extends _i9.PageRouteInfo<void> {
  const ProfileRoute({List<_i9.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}
