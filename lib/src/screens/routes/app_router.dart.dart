import 'package:auto_route/auto_route.dart';

import 'app_router.dart.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/',
          page: LandingRoute.page,
          children: [
            AutoRoute(path: 'world', page: HomeRoute.page),
            AutoRoute(path: 'join', page: JoinRoute.page),
            AutoRoute(path: 'explore', page: ExploreRoute.page),
            AutoRoute(
              path: 'notice',
              page: NoticeRoute.page,
              children: [
                RedirectRoute(path: '', redirectTo: 'notice'),
                AutoRoute(path: 'detail', page: NoticeDetailRoute.page),
              ],
            ),
            AutoRoute(path: 'profile', page: ProfileRoute.page),
          ],
        ),
        AutoRoute(page: LoginRoute.page, path: '/login'),
      ];
}
