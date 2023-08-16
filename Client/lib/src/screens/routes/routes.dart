import 'package:auto_route/auto_route.dart';

import 'routes.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();
  @override
  List<AutoRoute> get routes => [
        AutoRoute(path: '/login', page: LoginRoute.page),
        AutoRoute(
          path: '/',
          page: LandingRoute.page,
          children: [
            AutoRoute(
              path: 'place',
              page: PlacesRouter.page,
              children: [
                AutoRoute(path: '', page: HomeRoute.page),
                AutoRoute(path: ':eventID', page: HomeEventRoute.page),
              ],
            ),
            AutoRoute(
              path: 'join',
              page: EventsRouter.page,
              children: [
                AutoRoute(path: '', page: JoinRoute.page),
                AutoRoute(
                  path: ':eventID/board',
                  page: EventsBoardRouter.page,
                  children: [
                    AutoRoute(path: '', page: BoardEventRoute.page),
                    AutoRoute(path: 'write', page: BoardWriteEventRoute.page),
                    AutoRoute(
                        path: ':postID', page: BoardDetailEventRoute.page),
                  ],
                ),
                AutoRoute(
                  path: ':eventID',
                  page: EventsTabRouter.page,
                  children: [
                    AutoRoute(path: '', page: EventTabRoute.page, children: [
                      AutoRoute(path: '', page: InformEventRoute.page),
                      AutoRoute(path: 'notice', page: NoticeEventRoute.page),
                      AutoRoute(path: 'inform', page: InformEventRoute.page),
                      AutoRoute(path: 'time', page: TimeEventRoute.page)
                    ]),
                  ],
                ),
              ],
            ),
            AutoRoute(path: 'explore', page: ExploreRoute.page),
            AutoRoute(path: 'notice', page: NoticeRoute.page),
            AutoRoute(path: 'profile', page: ProfileRoute.page),
          ],
        ),
      ];
}

@RoutePage(name: 'PlacesRouter')
class PlacesRouterPage extends AutoRouter {}

@RoutePage(name: 'EventsRouter')
class EventsRouterPage extends AutoRouter {}

@RoutePage(name: 'EventsBoardRouter')
class EventsBoardRouterPage extends AutoRouter {}

@RoutePage(name: 'EventsTabRouter')
class EventsTabRouterPage extends AutoRouter {}
