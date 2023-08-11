import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:placex/src/blocs/mainBlocs/main_bloc.dart';

import 'app_router.dart.gr.dart';

List<BottomNavigationBarItem> bottomNavItems = <BottomNavigationBarItem>[
  BottomNavigationBarItem(
    icon: Image.asset(
      'assets/images/1x/home.png',
      width: 20,
      height: 20,
    ),
    label: '홈',
  ),
  BottomNavigationBarItem(
    icon: Image.asset(
      'assets/images/1x/join.png',
      width: 20,
      height: 20,
    ),
    label: '참여 장소',
  ),
  BottomNavigationBarItem(
    icon: Image.asset(
      'assets/images/1x/explore.png',
      width: 20,
      height: 20,
    ),
    label: '인기 장소',
  ),
  BottomNavigationBarItem(
    icon: Image.asset(
      'assets/images/1x/notice.png',
      width: 20,
      height: 20,
    ),
    label: '공지',
  ),
  BottomNavigationBarItem(
    icon: Image.asset(
      'assets/images/1x/profile.png',
      width: 20,
      height: 20,
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
    return BlocListener<MainBloc, MainBlocState>(
      listener: (context, state) {
        if (state is RequestKakaoLoginDenied) {
          context.router.root.replace(LoginRoute());
        }
      },
      child: AutoTabsScaffold(
        routes: const [
          HomeRoute(),
          JoinRoute(),
          ExploreRoute(),
          NoticeRoute(),
          ProfileRoute(),
        ],
        bottomNavigationBuilder: buildNav,
      ),
    );
  }

  Widget buildNav(BuildContext context, TabsRouter tabsRouter) {
    return BottomNavigationBar(
      elevation: 4,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      currentIndex: tabsRouter.activeIndex,
      onTap: tabsRouter.setActiveIndex,
      items: bottomNavItems,
    );
  }
}
