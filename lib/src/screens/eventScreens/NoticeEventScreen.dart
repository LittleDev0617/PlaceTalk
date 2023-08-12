import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class NoticeEventScreen extends StatelessWidget {
  const NoticeEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: ((BuildContext context, index) {
          return SizedBox(
            child: GestureDetector(
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
                    title: Text(
                      '유저',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
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
            ),
          );
        }),
      ),
    );
  }
}
