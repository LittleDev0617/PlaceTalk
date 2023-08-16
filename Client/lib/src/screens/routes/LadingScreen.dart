import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:placetalk/src/blocs/AuthBlocs/auth_bloc.dart';

import 'routes.gr.dart';

List<BottomNavigationBarItem> bottomNavItems = <BottomNavigationBarItem>[
  BottomNavigationBarItem(
    icon: Image.asset(
      'assets/images/home.png',
      width: 24,
      height: 24,
    ),
    label: '홈',
  ),
  BottomNavigationBarItem(
    icon: Image.asset(
      'assets/images/feed.png',
      width: 24,
      height: 24,
    ),
    label: '피드',
  ),
  BottomNavigationBarItem(
    icon: Image.asset(
      'assets/images/explore.png',
      width: 24,
      height: 24,
    ),
    label: '둘러보기',
  ),
  BottomNavigationBarItem(
    icon: Image.asset(
      'assets/images/join.png',
      width: 24,
      height: 24,
    ),
    label: '커뮤니티',
  ),
  BottomNavigationBarItem(
    icon: Image.asset(
      'assets/images/mypage.png',
      width: 24,
      height: 24,
    ),
    label: '마이페이지',
  ),
];

@RoutePage()
class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> with AutoRouteAware {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthDenied) {
          context.router.root.replace(const LoginRoute());
        }
      },
      child: WillPopScope(
        onWillPop: () async => false,
        child: AutoTabsScaffold(
          routes: const [
            PlacesRouter(),
            NoticeRoute(),
            ExploreRoute(),
            EventsRouter(),
            ProfileRoute(),
          ],
          bottomNavigationBuilder: buildNav,
        ),
      ),
    );
  }

  Widget buildNav(BuildContext context, TabsRouter tabsRouter) {
    return SizedBox(
      height: 85,
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 5,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        currentIndex: tabsRouter.activeIndex,
        onTap: tabsRouter.setActiveIndex,
        items: bottomNavItems,
      ),
    );
  }
}
