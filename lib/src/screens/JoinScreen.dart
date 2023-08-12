import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:placetalk/src/blocs/JoinBlocs/join_bloc.dart';

import 'routes/routes.gr.dart';

@RoutePage()
class JoinScreen extends StatelessWidget {
  const JoinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JoinBloc, JoinState>(
      builder: (context, state) {
        if (state is JoinInitial) {
          BlocProvider.of<JoinBloc>(context).add(
            FetchJoinDataEvent(),
          );
          return const Center(child: CircularProgressIndicator());
        } else if (state is JoinLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is JoinLoaded) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                '참여 중인 게시판',
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
              margin: const EdgeInsets.only(top: 15),
              padding: const EdgeInsets.all(10),
              child: ListView.separated(
                itemCount: 5,
                itemBuilder: ((BuildContext context, index) {
                  String item = state.itemsLatLng.keys.toList()[index];
                  return ListTile(
                    leading: const Column(
                      children: [
                        Icon(
                          Icons.bookmark_outline_rounded,
                          size: 28,
                        ),
                        SizedBox.shrink(),
                      ],
                    ),
                    title: GestureDetector(
                      onTap: () {
                        context.router.root.push(HomeRoute(
                          position: NLatLng(
                            state.itemsLatLng[item]!['latitude'],
                            state.itemsLatLng[item]!['longitude'],
                          ),
                        ));
                      },
                      child: Text(
                        item,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'time',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '${DateFormat('M.d').format(state.itemsLatLng[item]!['startDate'])}~${DateFormat('M.d').format(state.itemsLatLng[item]!['endDate'])}',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const VerticalDivider(),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                            context.router.push(
                              BoardEventRoute(name: item, eventID: 1),
                            );
                          },
                          child: const Icon(
                            Icons.chat_bubble_outline_outlined,
                            size: 32,
                            color: Color(0xffa5a5a5),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const VerticalDivider(),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                            context.router.push(
                              EventLandingRoute(name: item, eventID: 1),
                            );
                          },
                          child: const Icon(
                            Icons.assignment_outlined,
                            size: 32,
                            color: Color(0xffa5a5a5),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                separatorBuilder: (BuildContext context, int index) => Divider(
                  thickness: .5,
                  color: const Color(0xff707070).withOpacity(.6),
                ),
              ),
            ),
          );
        } else {
          return const Center(
            child: Text(
              '데이터 불러오기에 실패했어요',
            ),
          );
        }
      },
    );
  }
}
