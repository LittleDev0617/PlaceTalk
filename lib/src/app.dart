import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:placetalk/src/blocs/AuthBlocs/auth_bloc.dart';
import 'package:placetalk/src/blocs/ExploreBlocs/explore_bloc.dart';
import 'package:placetalk/src/blocs/JoinBlocs/join_bloc.dart';
import 'package:placetalk/src/repositories/AutoRepo.dart';
import 'package:placetalk/src/repositories/PlaceRepo.dart';

import 'blocs/PlaceBlocs/place_bloc.dart';
import 'screens/routes/routes.dart';

class App extends StatelessWidget {
  final _appRouter = AppRouter();

  App({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AuthRepo()),
        RepositoryProvider(create: (context) => PlaceRepo()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  AuthBloc(AuthRepo())..add(RequestKakaoLogin())),
          BlocProvider(
              create: (context) =>
                  PlaceBloc(PlaceRepo())..add(RequestLocationPermission())),
          BlocProvider(create: (context) => JoinBloc(PlaceRepo())),
          BlocProvider(create: (context) => ExploreBloc(PlaceRepo())),
        ],
        child: ScreenUtilInit(
          designSize: const Size(384, 832),
          builder: (context, child) => MaterialApp.router(
            routerConfig: _appRouter.config(
              navigatorObservers: () => [MyObserver()],
            ),
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Pretendard',
              useMaterial3: true,
            ),
          ),
        ),
      ),
    );
  }
}

class MyObserver extends AutoRouterObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    if (kDebugMode) {
      print('New route pushed: ${route.settings.name}');
    }
  }

  // only override to observer tab routes
  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    if (kDebugMode) {
      print('Tab route visited: ${route.name}');
    }
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    if (kDebugMode) {
      print('Tab route re-visited: ${route.name}');
    }
  }
}
