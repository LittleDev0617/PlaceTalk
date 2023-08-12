import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../routes/routes.gr.dart';

@RoutePage()
class HomeEventScreen extends StatelessWidget {
  final int eventID;
  final String name;

  const HomeEventScreen({
    super.key,
    required this.name,
    required this.position,
    @PathParam('eventID') required this.eventID,
  });
  final NLatLng position;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: const AutoLeadingButton(),
        title: Text(
          name,
          style: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            color: Colors.black,
            icon: const Icon(Icons.ios_share_outlined),
            onPressed: () {},
          ),
          IconButton(
            color: const Color(0xffff7d7d),
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: NaverMap(
        options: NaverMapViewOptions(
          initialCameraPosition: NCameraPosition(target: position, zoom: 14.5),
          locationButtonEnable: true,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        shape: const CircleBorder(),
        onPressed: () {
          AutoRouter.of(context).parent<TabsRouter>()!.navigate(
                EventsRouter(
                  children: [
                    EventLandingRoute(
                      eventID: eventID,
                      name: name,
                      children: const [
                        TimeEventRoute(),
                      ],
                    ),
                  ],
                ),
              );
        },
        child: const Icon(
          Icons.alarm,
          color: Color(0xffADADAD),
        ),
      ),
    );
  }
}
