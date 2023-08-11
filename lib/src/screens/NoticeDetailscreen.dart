import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../components/buttons.dart';

@RoutePage()
class NoticeDetailScreen extends StatelessWidget {
  const NoticeDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const NoticeDetailPage();
  }
}

class NoticeDetailPage extends StatelessWidget {
  const NoticeDetailPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          '게시판 이름',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 9),
            child: CircleAvatarIconButton(
              iconSize: 27,
              backgroundColor: Colors.transparent,
              iconColor: const Color(0xffFF7D7D),
              icon: Icons.notifications_outlined,
              onPressed: () {},
            ),
          ),
        ],
        backgroundColor: const Color(0xffF7F7F7),
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {},
              child: ListTile(
                title: const Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/profile.jpg'),
                    ),
                    SizedBox(width: 14),
                    Text(
                      '건국대학교 두울',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.more_vert),
                  ],
                ),
                subtitle: Container(
                  margin: const EdgeInsets.only(top: 25),
                  child: GestureDetector(
                    onTap: () {},
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return AspectRatio(
                                aspectRatio: 4 / 3,
                                child: Container(
                                  margin: const EdgeInsets.only(right: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.amber),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          '안녕하세요 건국대학교 총학생회 두울입니다. 오늘 뉴진스는 금일 오후 5시부터 공연 시작합니다.',
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.2,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 1),
                        Text(
                          '2023.09.12',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black.withOpacity(0.65),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
