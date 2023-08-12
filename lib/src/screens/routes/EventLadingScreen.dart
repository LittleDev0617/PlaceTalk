import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:placetalk/src/screens/routes/routes.gr.dart';

@RoutePage()
class EventLandingScreen extends StatelessWidget {
  final int eventID;
  final String name;
  const EventLandingScreen(
      {super.key,
      @PathParam('eventID') required this.eventID,
      required this.name});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.tabBar(
        routes: const [
          NoticeEventRoute(),
          InformEventRoute(),
          TimeEventRoute(),
        ],
        builder: (context, child, controller) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                name,
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              actions: [
                IconButton(
                  color: const Color(0xffff7d7d),
                  icon: const Icon(Icons.notifications_outlined),
                  onPressed: () {},
                ),
                const SizedBox(width: 24),
              ],
              backgroundColor: const Color(0xfff7f7f7),
              centerTitle: true,
              leading: const AutoLeadingButton(color: Colors.black),
              bottom: TabBar(
                controller: controller,
                indicatorWeight: 4,
                labelColor: const Color(0xffff7d7d),
                labelStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelColor: const Color(0xffd7dadc),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                tabs: const [
                  Tab(text: '피드'),
                  Tab(text: '행사 정보·예매'),
                  Tab(text: '일정표'),
                ],
              ),
            ),
            body: child,
          );
        });
  }
}
