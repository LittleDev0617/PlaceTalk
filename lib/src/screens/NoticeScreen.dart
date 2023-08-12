import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'routes/routes.gr.dart';

@RoutePage()
class NoticeScreen extends StatelessWidget {
  const NoticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '전체 피드',
          style: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
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
      ),
      body: Container(
        padding: const EdgeInsets.all(24),
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: ((BuildContext context, index) {
            return SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                    leading: const CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage(
                        'assets/images/profile.png',
                      ),
                    ),
                    title: InkWell(
                      onTap: () {
                        AutoRouter.of(context).navigate(
                          EventsRouter(
                            children: [
                              EventLandingRoute(
                                eventID: index,
                                name: index.toString(),
                                children: const [
                                  NoticeEventRoute(),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      child: Text(
                        '유저',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {},
                      iconSize: 24,
                      icon: const Icon(
                        Icons.more_vert,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '제목',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        height: 130,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: 5,
                          itemBuilder: (((BuildContext context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              margin: const EdgeInsets.only(right: 5),
                              child: const AspectRatio(aspectRatio: 16 / 13),
                            );
                          })),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        '작성일자',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black.withOpacity(.46),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 35),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
