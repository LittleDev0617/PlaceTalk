import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

import 'app_router.dart.gr.dart';

List<BottomNavigationBarItem> bottomNavItems = const <BottomNavigationBarItem>[
  BottomNavigationBarItem(
    icon: Icon(Icons.home_outlined),
    label: 'Map',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.pin_drop_rounded),
    label: 'Join',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.grid_3x3),
    label: 'Explore',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.push_pin_rounded),
    label: 'Notice',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.person_2_rounded),
    label: 'Profile',
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
    return AutoTabsScaffold(
      routes: const [
        HomeRoute(),
        JoinRoute(),
        ExploreRoute(),
        NoticeRoute(),
        ProfileRoute(),
      ],
      bottomNavigationBuilder: buildNav,
    );
  }

  Widget buildNav(BuildContext context, TabsRouter tabsRouter) {
    return BottomNavigationBar(
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      currentIndex: tabsRouter.activeIndex,
      onTap: tabsRouter.setActiveIndex,
      items: bottomNavItems,
    );
  }
}
