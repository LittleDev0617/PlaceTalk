import 'package:auto_route/auto_route.dart';

import 'app_router.dart.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page, path: '/login', initial: true),
        AutoRoute(
          path: '/',
          page: LandingRoute.page,
          children: [
            RedirectRoute(path: '', redirectTo: 'world'),
            AutoRoute(path: 'world', page: HomeRoute.page),
            AutoRoute(
              path: 'join',
              page: JoinRoute.page,
            ),
            AutoRoute(path: 'test', page: JoinRoute.page),
            AutoRoute(
              path: 'explore',
              page: ExploreRoute.page,
            ),
          ],
        ),
      ];
}
