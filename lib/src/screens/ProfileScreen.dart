import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:placetalk/src/blocs/AuthBlocs/auth_bloc.dart';

import '../blocs/JoinBlocs/join_bloc.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '마이페이지',
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
        // body: Center(
        //   child: TextButton(
        //     onPressed: () {
        //       BlocProvider.of<AuthBloc>(context).add(
        //         RequestKakaoLogout(),
        //       );
        //     },
        //     child: const Text('로그아웃'),
        //   ),
        // ),
        body: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              height: MediaQuery.of(context).size.height * 0.15,
              color: const Color(0xffF7F7F7),
              child: ListTile(
                leading: const SizedBox(
                  width: 60,
                  height: 60,
                  child: CircleAvatar(),
                ),
                title: Text(
                  '주인공',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text('@gmail.com'),
                trailing: OutlinedButton(
                  onPressed: () {
                    BlocProvider.of<AuthBloc>(context).add(
                      RequestKakaoLogout(),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xffadadad),
                    ),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    side: MaterialStateProperty.all<BorderSide>(
                      BorderSide.none,
                    ),
                  ),
                  child: Text(
                    '로그아웃',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ),
            ),
            const TabBar(
              labelColor: Color(0xffFF7D7D),
              indicatorColor: Color(0xffFF7D7D),
              tabs: [
                Tab(text: '작성내역'),
                Tab(text: '참여 중인 핫플'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  const Center(child: Text('탭1 내용')),
                  Center(
                    child: BlocBuilder<JoinBloc, JoinState>(
                      builder: (context, state) {
                        if (state is JoinInitial) {
                          BlocProvider.of<JoinBloc>(context).add(
                            FetchJoinDataEvent(),
                          );
                          return const CircularProgressIndicator();
                        } else if (state is JoinLoading) {
                          return const CircularProgressIndicator();
                        } else if (state is JoinLoaded) {
                          return Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: ListView.builder(
                              itemCount: state.itemsLatLng.length,
                              itemBuilder: (BuildContext context, int index) {
                                String item =
                                    state.itemsLatLng.keys.toList()[index];
                                return Column(
                                  children: [
                                    ListTile(
                                      title: Text(
                                        item,
                                        style: const TextStyle(
                                          letterSpacing: -1,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                        ),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${DateFormat('M.d').format(state.itemsLatLng[item]!['startDate'])}~${DateFormat('M.d').format(state.itemsLatLng[item]!['endDate'])}',
                                            style: const TextStyle(
                                              letterSpacing: -1,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            constraints: const BoxConstraints(
                                              maxHeight: 27,
                                            ),
                                            child: OutlinedButton(
                                              onPressed: () {},
                                              child: const Text(
                                                '나가기',
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 35),
                                    Divider(
                                      thickness: 1,
                                      color:
                                          Color(0xffADADAD).withOpacity(0.45),
                                    ),
                                  ],
                                );
                              },
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
