import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../blocs/JoinBlocs/join_bloc.dart';
import '../blocs/mainBlocs/main_bloc.dart';
import '../components/buttons.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfilePage();
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text(
            '마이페이지',
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
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                height: MediaQuery.of(context).size.height * 0.15,
                color: Color(0xffF7F7F7),
                child: ListTile(
                  leading: const SizedBox(
                    width: 60,
                    height: 60,
                    child: CircleAvatar(),
                  ),
                  title: Text('주인공'),
                  subtitle: Text('@gmail.com'),
                  trailing: Container(
                    constraints: BoxConstraints(
                      maxHeight: 27,
                    ),
                    child: OutlinedButton(
                      onPressed: () {
                        BlocProvider.of<MainBloc>(context).add(
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
                    Center(child: Text('탭1 내용')),
                    Center(
                      child: BlocBuilder<JoinBloc, JoinBlocState>(
                        builder: (context, state) {
                          if (state is JoinInitial) {
                            BlocProvider.of<JoinBloc>(context).add(
                              FetchJoinDataEvent(),
                            );
                            return const CircularProgressIndicator();
                          } else if (state is JoinDataLoading) {
                            return const CircularProgressIndicator();
                          } else if (state is JoinDataLoaded) {
                            List<String> namesList = state.namesList;
                            List<Map<String, dynamic>> dateRanges =
                                state.datas.values.map((value) {
                              return {
                                'start_date': value['start_date'] ?? '',
                                'end_date': value['end_date'] ?? '',
                              };
                            }).toList();
                            return Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: ListView.builder(
                                itemCount: namesList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    children: [
                                      ListTile(
                                        title: Text(
                                          namesList[index],
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
                                              '18:00~21:00',
                                              style: const TextStyle(
                                                letterSpacing: -1,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 13,
                                              ),
                                            ),
                                            Text(
                                              '${dateRanges[index]['start_date']}~${dateRanges[index]['end_date']}',
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
      ),
    );
  }
}
