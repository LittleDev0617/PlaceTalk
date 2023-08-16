import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:placetalk/src/blocs/AuthBlocs/auth_bloc.dart';

import '../blocs/JoinBlocs/join_bloc.dart';
import '../components/CustomDialog.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            '마이페이지',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          actions: [
            IconButton(
              color: const Color(0xffff7d7d),
              icon: const Icon(Icons.notifications_outlined),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: ((BuildContext context) {
                      return const CustomAlertDialog();
                    }));
              },
            ),
            const SizedBox(width: 24),
          ],
          backgroundColor: const Color(0xfff7f7f7),
          centerTitle: true,
        ),
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, authstate) {
            if (authstate is AuthGranted) {
              return Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    height: MediaQuery.of(context).size.height * 0.15,
                    color: const Color(0xffF7F7F7),
                    child: ListTile(
                      leading: const SizedBox(
                        width: 60,
                        height: 60,
                        child: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/profile.png'),
                        ),
                      ),
                      title: SizedBox(
                        width: 160,
                        child: Text(
                          authstate.nickname,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      subtitle: Text(authstate.user.email == null
                          ? ""
                          : authstate.user.email!),
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
                      Tab(text: '참여 중인 게시판'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        const Center(child: Text('작성하신 게시글이 없습니다.')),
                        Center(
                          child: BlocBuilder<JoinBloc, JoinState>(
                            builder: (context, state) {
                              if (state is JoinInitial) {
                                BlocProvider.of<JoinBloc>(context).add(
                                  FetchJoinDataEvent(authstate.user.kakaoID),
                                );
                                return const CircularProgressIndicator();
                              } else if (state is JoinLoading) {
                                return const CircularProgressIndicator();
                              } else if (state is JoinLoaded) {
                                return Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: state.itemsLatLng.isEmpty
                                      ? const Center(
                                          child: Text(
                                          '참여 중인 게시판이 없어요',
                                          style: TextStyle(
                                              color: Color(0xffadadad),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ))
                                      : ListView.builder(
                                          itemCount: state.itemsLatLng.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            String item = state.itemsLatLng.keys
                                                .toList()[index];
                                            return Column(
                                              children: [
                                                ListTile(
                                                  title: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Icon(
                                                        Icons.bookmark_rounded,
                                                        color: state.itemsLatLng[
                                                                        item]![
                                                                    'state'] ==
                                                                0
                                                            ? const Color(
                                                                0xff82E3CD)
                                                            : const Color(
                                                                0xffFF7D7D),
                                                      ),
                                                      const SizedBox(width: 10),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            item,
                                                            style:
                                                                const TextStyle(
                                                              letterSpacing: -1,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 5),
                                                          Text(
                                                            '${DateFormat('M.d').format(state.itemsLatLng[item]!['startDate'])}~${DateFormat('M.d').format(state.itemsLatLng[item]!['endDate'])}',
                                                            style:
                                                                const TextStyle(
                                                              letterSpacing: -1,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  trailing: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Container(
                                                        constraints:
                                                            const BoxConstraints(
                                                          maxHeight: 27,
                                                        ),
                                                        child: OutlinedButton(
                                                          onPressed: () {
                                                            BlocProvider.of<
                                                                        JoinBloc>(
                                                                    context)
                                                                .add(
                                                              ToExitEvnet(
                                                                state.itemsLatLng[
                                                                        item]![
                                                                    'place_id'],
                                                              ),
                                                            );

                                                            BlocProvider.of<
                                                                        JoinBloc>(
                                                                    context)
                                                                .add(
                                                              FetchJoinDataEvent(
                                                                state.itemsLatLng[
                                                                        item]![
                                                                    'place_id'],
                                                              ),
                                                            );
                                                          },
                                                          child: const Text(
                                                            '나가기',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 35),
                                                Divider(
                                                  thickness: 1,
                                                  color: const Color(0xffADADAD)
                                                      .withOpacity(0.45),
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
              );
            } else {
              return const Center(child: Text('데이터 불러오기에 실패했어요.'));
            }
          },
        ),
      ),
    );
  }
}
