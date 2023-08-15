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
          placeID: args.placeID,
          name: args.name,
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
    EventTabRoute.name: (routeData) {
      final args = routeData.argsAs<EventTabRouteArgs>();
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.EventTabScreen(
          key: args.key,
          placeID: args.placeID,
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
    EventsTabRouter.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.EventsTabRouterPage(),
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
          placeID: args.placeID,
          locID: args.locID,
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
      final args = routeData.argsAs<InformEventRouteArgs>(
          orElse: () => const InformEventRouteArgs());
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.InformEventScreen(
          key: args.key,
          placeID: args.placeID,
          name: args.name,
        ),
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
      final args = routeData.argsAs<NoticeEventRouteArgs>(
          orElse: () => const NoticeEventRouteArgs());
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i13.NoticeEventScreen(
          key: args.key,
          placeID: args.placeID,
          name: args.name,
        ),
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
      final args = routeData.argsAs<TimeEventRouteArgs>(
          orElse: () => const TimeEventRouteArgs());
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i16.TimeEventScreen(
          key: args.key,
          placeID: args.placeID,
          name: args.name,
        ),
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
    required int placeID,
    required String name,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          BoardEventRoute.name,
          args: BoardEventRouteArgs(
            key: key,
            placeID: placeID,
            name: name,
          ),
          rawPathParams: {'placeID': placeID},
          initialChildren: children,
        );

  static const String name = 'BoardEventRoute';

  static const _i17.PageInfo<BoardEventRouteArgs> page =
      _i17.PageInfo<BoardEventRouteArgs>(name);
}

class BoardEventRouteArgs {
  const BoardEventRouteArgs({
    this.key,
    required this.placeID,
    required this.name,
  });

  final _i18.Key? key;

  final int placeID;

  final String name;

  @override
  String toString() {
    return 'BoardEventRouteArgs{key: $key, placeID: $placeID, name: $name}';
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
/// [_i4.EventTabScreen]
class EventTabRoute extends _i17.PageRouteInfo<EventTabRouteArgs> {
  EventTabRoute({
    _i18.Key? key,
    required int placeID,
    required String name,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          EventTabRoute.name,
          args: EventTabRouteArgs(
            key: key,
            placeID: placeID,
            name: name,
          ),
          rawPathParams: {'eventID': placeID},
          initialChildren: children,
        );

  static const String name = 'EventTabRoute';

  static const _i17.PageInfo<EventTabRouteArgs> page =
      _i17.PageInfo<EventTabRouteArgs>(name);
}

class EventTabRouteArgs {
  const EventTabRouteArgs({
    this.key,
    required this.placeID,
    required this.name,
  });

  final _i18.Key? key;

  final int placeID;

  final String name;

  @override
  String toString() {
    return 'EventTabRouteArgs{key: $key, placeID: $placeID, name: $name}';
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
/// [_i5.EventsTabRouterPage]
class EventsTabRouter extends _i17.PageRouteInfo<void> {
  const EventsTabRouter({List<_i17.PageRouteInfo>? children})
      : super(
          EventsTabRouter.name,
          initialChildren: children,
        );

  static const String name = 'EventsTabRouter';

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
    required int placeID,
    required int locID,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          HomeEventRoute.name,
          args: HomeEventRouteArgs(
            key: key,
            name: name,
            position: position,
            placeID: placeID,
            locID: locID,
          ),
          rawPathParams: {'placeID': locID},
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
    required this.placeID,
    required this.locID,
  });

  final _i18.Key? key;

  final String name;

  final _i19.NLatLng position;

  final int placeID;

  final int locID;

  @override
  String toString() {
    return 'HomeEventRouteArgs{key: $key, name: $name, position: $position, placeID: $placeID, locID: $locID}';
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
class InformEventRoute extends _i17.PageRouteInfo<InformEventRouteArgs> {
  InformEventRoute({
    _i18.Key? key,
    int? placeID,
    String? name,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          InformEventRoute.name,
          args: InformEventRouteArgs(
            key: key,
            placeID: placeID,
            name: name,
          ),
          initialChildren: children,
        );

  static const String name = 'InformEventRoute';

  static const _i17.PageInfo<InformEventRouteArgs> page =
      _i17.PageInfo<InformEventRouteArgs>(name);
}

class InformEventRouteArgs {
  const InformEventRouteArgs({
    this.key,
    this.placeID,
    this.name,
  });

  final _i18.Key? key;

  final int? placeID;

  final String? name;

  @override
  String toString() {
    return 'InformEventRouteArgs{key: $key, placeID: $placeID, name: $name}';
  }
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
class NoticeEventRoute extends _i17.PageRouteInfo<NoticeEventRouteArgs> {
  NoticeEventRoute({
    _i18.Key? key,
    int? placeID,
    String? name,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          NoticeEventRoute.name,
          args: NoticeEventRouteArgs(
            key: key,
            placeID: placeID,
            name: name,
          ),
          initialChildren: children,
        );

  static const String name = 'NoticeEventRoute';

  static const _i17.PageInfo<NoticeEventRouteArgs> page =
      _i17.PageInfo<NoticeEventRouteArgs>(name);
}

class NoticeEventRouteArgs {
  const NoticeEventRouteArgs({
    this.key,
    this.placeID,
    this.name,
  });

  final _i18.Key? key;

  final int? placeID;

  final String? name;

  @override
  String toString() {
    return 'NoticeEventRouteArgs{key: $key, placeID: $placeID, name: $name}';
  }
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
class TimeEventRoute extends _i17.PageRouteInfo<TimeEventRouteArgs> {
  TimeEventRoute({
    _i18.Key? key,
    int? placeID,
    String? name,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          TimeEventRoute.name,
          args: TimeEventRouteArgs(
            key: key,
            placeID: placeID,
            name: name,
          ),
          initialChildren: children,
        );

  static const String name = 'TimeEventRoute';

  static const _i17.PageInfo<TimeEventRouteArgs> page =
      _i17.PageInfo<TimeEventRouteArgs>(name);
}

class TimeEventRouteArgs {
  const TimeEventRouteArgs({
    this.key,
    this.placeID,
    this.name,
  });

  final _i18.Key? key;

  final int? placeID;

  final String? name;

  @override
  String toString() {
    return 'TimeEventRouteArgs{key: $key, placeID: $placeID, name: $name}';
  }
}
