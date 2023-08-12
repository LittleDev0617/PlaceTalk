import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:placetalk/src/components/CustomButtons.dart';
import 'package:placetalk/src/screens/routes/routes.gr.dart';

@RoutePage()
class BoardEventScreen extends StatefulWidget {
  final int eventID;
  final String name;
  const BoardEventScreen({
    super.key,
    required this.name,
    @PathParam('eventID') required this.eventID,
  });

  @override
  State<BoardEventScreen> createState() => _BoardEventScreenState();
}

class _BoardEventScreenState extends State<BoardEventScreen> {
  bool _isLatestOrder = true; // 초기 값

  void _toggleOrder() {
    setState(() {
      _isLatestOrder = !_isLatestOrder; // 값 토글
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.white.withOpacity(.9),
            onPressed: () {},
            shape: const CircleBorder(),
            elevation: 3,
            child: const SizedBox(
              height: 60,
              width: 60,
              child: Icon(
                Icons.map_outlined,
                color: Color(0xffff7d7d),
                size: 32,
              ),
            ),
          ),
          const SizedBox(height: 15),
          FloatingActionButton(
            onPressed: () {
              context.router.push(BoardWriteEventRoute(name: widget.name));
            },
            shape: const CircleBorder(),
            elevation: 3,
            child: const SizedBox(
              height: 60,
              width: 60,
              child: Icon(
                Icons.edit_rounded,
                size: 32,
              ),
            ),
          ),
        ],
      ),
      appBar: AppBar(
        title: Text(
          widget.name,
          style: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        actions: [
          IconButton(
            color: Colors.black,
            icon: const Icon(Icons.ios_share),
            onPressed: () {},
          ),
          IconButton(
            color: const Color(0xffff7d7d),
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
        backgroundColor: const Color(0xfff7f7f7),
        centerTitle: true,
        leading: const AutoLeadingButton(color: Colors.black),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      border: Border.all(
                        width: .5,
                        color: const Color(0xff707070).withOpacity(.55),
                      ),
                    ),
                    child: const Icon(
                      Icons.search_rounded,
                      size: 21,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                const Icon(Icons.notes_rounded),
                const SizedBox(width: 10),
                InkWell(
                  onTap: () {
                    _toggleOrder();
                  },
                  child: Text(
                    _isLatestOrder ? '최신 순' : '좋아요 순',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: ((BuildContext context, index) {
                  return SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          onTap: () {
                            context.router.push(
                              BoardDetailEventRoute(
                                  name: widget.name, postID: index),
                            );
                          },
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          leading: Container(
                            margin: const EdgeInsets.only(right: 5),
                            child: const CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage: AssetImage(
                                'assets/images/profile.png',
                              ),
                            ),
                          ),
                          title: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '익명',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () {},
                                iconSize: 24,
                                icon: const Icon(
                                  Icons.more_vert,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 180,
                                child: Text(
                                  '저는 내일 광진구쪽으로 가보려고요 건대가 짱이에요 우오아아',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '작성일자',
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black.withOpacity(.56),
                                    ),
                                  ),
                                  const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CustomIconText(
                                        icons: Icon(
                                          Icons.favorite_border_outlined,
                                          color: Colors.black,
                                        ),
                                        text: '4',
                                      ),
                                      SizedBox(width: 15),
                                      CustomIconText(
                                        icons: Icon(
                                          Icons.chat_bubble_outline,
                                          color: Colors.black,
                                        ),
                                        text: '4',
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                separatorBuilder: (BuildContext context, int index) => Divider(
                  thickness: 1,
                  color: const Color(0xff707070).withOpacity(.3),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
