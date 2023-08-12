// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i17;
import 'package:flutter/material.dart' as _i18;
import 'package:flutter_naver_map/flutter_naver_map.dart' as _i19;
import 'package:placetalk/src/screens/eventScreens/BoardDetailEventScreen.dart'
    as _i1;
import 'package:placetalk/src/screens/eventScreens/BoardEventScreen.dart'
    as _i2;
import 'package:placetalk/src/screens/eventScreens/BoardWriteEventScreen.dart'
    as _i3;
import 'package:placetalk/src/screens/eventScreens/HomeEventScreen.dart' as _i7;
import 'package:placetalk/src/screens/eventScreens/InformEventScreen.dart'
    as _i9;
import 'package:placetalk/src/screens/eventScreens/NoticeEventScreen.dart'
    as _i13;
import 'package:placetalk/src/screens/eventScreens/TimeEventScreen.dart'
    as _i16;
import 'package:placetalk/src/screens/ExploreScreen.dart' as _i6;
import 'package:placetalk/src/screens/HomeScreen.dart' as _i8;
import 'package:placetalk/src/screens/JoinScreen.dart' as _i10;
import 'package:placetalk/src/screens/LoginScreen.dart' as _i12;
import 'package:placetalk/src/screens/NoticeScreen.dart' as _i14;
import 'package:placetalk/src/screens/ProfileScreen.dart' as _i15;
import 'package:placetalk/src/screens/routes/EventLadingScreen.dart' as _i4;
import 'package:placetalk/src/screens/routes/LadingScreen.dart' as _i11;
import 'package:placetalk/src/screens/routes/routes.dart' as _i5;

abstract class $AppRouter extends _i17.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i17.PageFactory> pagesMap = {
    BoardDetailEventRoute.name: (routeData) {
      final args = routeData.argsAs<BoardDetailEventRouteArgs>();
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.BoardDetailEventScreen(
          key: args.key,
          name: args.name,
          postID: args.postID,
        ),
      );
    },
    BoardEventRoute.name: (routeData) {
      final args = routeData.argsAs<BoardEventRouteArgs>();
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.BoardEventScreen(
          key: args.key,
          name: args.name,
          eventID: args.eventID,
        ),
      );
    },
    BoardWriteEventRoute.name: (routeData) {
      final args = routeData.argsAs<BoardWriteEventRouteArgs>();
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.BoardWriteEventScreen(
          key: args.key,
          name: args.name,
        ),
      );
    },
    EventLandingRoute.name: (routeData) {
      final args = routeData.argsAs<EventLandingRouteArgs>();
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.EventLandingScreen(
          key: args.key,
          eventID: args.eventID,
          name: args.name,
        ),
      );
    },
    EventsBoardRouter.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.EventsBoardRouterPage(),
      );
    },
    EventsRouter.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.EventsRouterPage(),
      );
    },
    ExploreRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.ExploreScreen(),
      );
    },
    HomeEventRoute.name: (routeData) {
      final args = routeData.argsAs<HomeEventRouteArgs>();
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.HomeEventScreen(
          key: args.key,
          name: args.name,
          position: args.position,
          eventID: args.eventID,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      final args =
          routeData.argsAs<HomeRouteArgs>(orElse: () => const HomeRouteArgs());
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.HomeScreen(
          key: args.key,
          position: args.position,
        ),
      );
    },
    InformEventRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.InformEventScreen(),
      );
    },
    JoinRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.JoinScreen(),
      );
    },
    LandingRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.LandingScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.LoginScreen(),
      );
    },
    NoticeEventRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.NoticeEventScreen(),
      );
    },
    NoticeRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.NoticeScreen(),
      );
    },
    PlacesRouter.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.PlacesRouterPage(),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.ProfileScreen(),
      );
    },
    TimeEventRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i16.TimeEventScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.BoardDetailEventScreen]
class BoardDetailEventRoute
    extends _i17.PageRouteInfo<BoardDetailEventRouteArgs> {
  BoardDetailEventRoute({
    _i18.Key? key,
    required String name,
    required int postID,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          BoardDetailEventRoute.name,
          args: BoardDetailEventRouteArgs(
            key: key,
            name: name,
            postID: postID,
          ),
          rawPathParams: {'postID': postID},
          initialChildren: children,
        );

  static const String name = 'BoardDetailEventRoute';

  static const _i17.PageInfo<BoardDetailEventRouteArgs> page =
      _i17.PageInfo<BoardDetailEventRouteArgs>(name);
}

class BoardDetailEventRouteArgs {
  const BoardDetailEventRouteArgs({
    this.key,
    required this.name,
    required this.postID,
  });

  final _i18.Key? key;

  final String name;

  final int postID;

  @override
  String toString() {
    return 'BoardDetailEventRouteArgs{key: $key, name: $name, postID: $postID}';
  }
}

/// generated route for
/// [_i2.BoardEventScreen]
class BoardEventRoute extends _i17.PageRouteInfo<BoardEventRouteArgs> {
  BoardEventRoute({
    _i18.Key? key,
    required String name,
    required int eventID,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          BoardEventRoute.name,
          args: BoardEventRouteArgs(
            key: key,
            name: name,
            eventID: eventID,
          ),
          rawPathParams: {'eventID': eventID},
          initialChildren: children,
        );

  static const String name = 'BoardEventRoute';

  static const _i17.PageInfo<BoardEventRouteArgs> page =
      _i17.PageInfo<BoardEventRouteArgs>(name);
}

class BoardEventRouteArgs {
  const BoardEventRouteArgs({
    this.key,
    required this.name,
    required this.eventID,
  });

  final _i18.Key? key;

  final String name;

  final int eventID;

  @override
  String toString() {
    return 'BoardEventRouteArgs{key: $key, name: $name, eventID: $eventID}';
  }
}

/// generated route for
/// [_i3.BoardWriteEventScreen]
class BoardWriteEventRoute
    extends _i17.PageRouteInfo<BoardWriteEventRouteArgs> {
  BoardWriteEventRoute({
    _i18.Key? key,
    required String name,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          BoardWriteEventRoute.name,
          args: BoardWriteEventRouteArgs(
            key: key,
            name: name,
          ),
          initialChildren: children,
        );

  static const String name = 'BoardWriteEventRoute';

  static const _i17.PageInfo<BoardWriteEventRouteArgs> page =
      _i17.PageInfo<BoardWriteEventRouteArgs>(name);
}

class BoardWriteEventRouteArgs {
  const BoardWriteEventRouteArgs({
    this.key,
    required this.name,
  });

  final _i18.Key? key;

  final String name;

  @override
  String toString() {
    return 'BoardWriteEventRouteArgs{key: $key, name: $name}';
  }
}

/// generated route for
/// [_i4.EventLandingScreen]
class EventLandingRoute extends _i17.PageRouteInfo<EventLandingRouteArgs> {
  EventLandingRoute({
    _i18.Key? key,
    required int eventID,
    required String name,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          EventLandingRoute.name,
          args: EventLandingRouteArgs(
            key: key,
            eventID: eventID,
            name: name,
          ),
          rawPathParams: {'eventID': eventID},
          initialChildren: children,
        );

  static const String name = 'EventLandingRoute';

  static const _i17.PageInfo<EventLandingRouteArgs> page =
      _i17.PageInfo<EventLandingRouteArgs>(name);
}

class EventLandingRouteArgs {
  const EventLandingRouteArgs({
    this.key,
    required this.eventID,
    required this.name,
  });

  final _i18.Key? key;

  final int eventID;

  final String name;

  @override
  String toString() {
    return 'EventLandingRouteArgs{key: $key, eventID: $eventID, name: $name}';
  }
}

/// generated route for
/// [_i5.EventsBoardRouterPage]
class EventsBoardRouter extends _i17.PageRouteInfo<void> {
  const EventsBoardRouter({List<_i17.PageRouteInfo>? children})
      : super(
          EventsBoardRouter.name,
          initialChildren: children,
        );

  static const String name = 'EventsBoardRouter';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i5.EventsRouterPage]
class EventsRouter extends _i17.PageRouteInfo<void> {
  const EventsRouter({List<_i17.PageRouteInfo>? children})
      : super(
          EventsRouter.name,
          initialChildren: children,
        );

  static const String name = 'EventsRouter';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i6.ExploreScreen]
class ExploreRoute extends _i17.PageRouteInfo<void> {
  const ExploreRoute({List<_i17.PageRouteInfo>? children})
      : super(
          ExploreRoute.name,
          initialChildren: children,
        );

  static const String name = 'ExploreRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i7.HomeEventScreen]
class HomeEventRoute extends _i17.PageRouteInfo<HomeEventRouteArgs> {
  HomeEventRoute({
    _i18.Key? key,
    required String name,
    required _i19.NLatLng position,
    required int eventID,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          HomeEventRoute.name,
          args: HomeEventRouteArgs(
            key: key,
            name: name,
            position: position,
            eventID: eventID,
          ),
          rawPathParams: {'eventID': eventID},
          initialChildren: children,
        );

  static const String name = 'HomeEventRoute';

  static const _i17.PageInfo<HomeEventRouteArgs> page =
      _i17.PageInfo<HomeEventRouteArgs>(name);
}

class HomeEventRouteArgs {
  const HomeEventRouteArgs({
    this.key,
    required this.name,
    required this.position,
    required this.eventID,
  });

  final _i18.Key? key;

  final String name;

  final _i19.NLatLng position;

  final int eventID;

  @override
  String toString() {
    return 'HomeEventRouteArgs{key: $key, name: $name, position: $position, eventID: $eventID}';
  }
}

/// generated route for
/// [_i8.HomeScreen]
class HomeRoute extends _i17.PageRouteInfo<HomeRouteArgs> {
  HomeRoute({
    _i18.Key? key,
    _i19.NLatLng? position,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          HomeRoute.name,
          args: HomeRouteArgs(
            key: key,
            position: position,
          ),
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i17.PageInfo<HomeRouteArgs> page =
      _i17.PageInfo<HomeRouteArgs>(name);
}

class HomeRouteArgs {
  const HomeRouteArgs({
    this.key,
    this.position,
  });

  final _i18.Key? key;

  final _i19.NLatLng? position;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key, position: $position}';
  }
}

/// generated route for
/// [_i9.InformEventScreen]
class InformEventRoute extends _i17.PageRouteInfo<void> {
  const InformEventRoute({List<_i17.PageRouteInfo>? children})
      : super(
          InformEventRoute.name,
          initialChildren: children,
        );

  static const String name = 'InformEventRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i10.JoinScreen]
class JoinRoute extends _i17.PageRouteInfo<void> {
  const JoinRoute({List<_i17.PageRouteInfo>? children})
      : super(
          JoinRoute.name,
          initialChildren: children,
        );

  static const String name = 'JoinRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i11.LandingScreen]
class LandingRoute extends _i17.PageRouteInfo<void> {
  const LandingRoute({List<_i17.PageRouteInfo>? children})
      : super(
          LandingRoute.name,
          initialChildren: children,
        );

  static const String name = 'LandingRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i12.LoginScreen]
class LoginRoute extends _i17.PageRouteInfo<void> {
  const LoginRoute({List<_i17.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i13.NoticeEventScreen]
class NoticeEventRoute extends _i17.PageRouteInfo<void> {
  const NoticeEventRoute({List<_i17.PageRouteInfo>? children})
      : super(
          NoticeEventRoute.name,
          initialChildren: children,
        );

  static const String name = 'NoticeEventRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i14.NoticeScreen]
class NoticeRoute extends _i17.PageRouteInfo<void> {
  const NoticeRoute({List<_i17.PageRouteInfo>? children})
      : super(
          NoticeRoute.name,
          initialChildren: children,
        );

  static const String name = 'NoticeRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i5.PlacesRouterPage]
class PlacesRouter extends _i17.PageRouteInfo<void> {
  const PlacesRouter({List<_i17.PageRouteInfo>? children})
      : super(
          PlacesRouter.name,
          initialChildren: children,
        );

  static const String name = 'PlacesRouter';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i15.ProfileScreen]
class ProfileRoute extends _i17.PageRouteInfo<void> {
  const ProfileRoute({List<_i17.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i16.TimeEventScreen]
class TimeEventRoute extends _i17.PageRouteInfo<void> {
  const TimeEventRoute({List<_i17.PageRouteInfo>? children})
      : super(
          TimeEventRoute.name,
          initialChildren: children,
        );

  static const String name = 'TimeEventRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}
