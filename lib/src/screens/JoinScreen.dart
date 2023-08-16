import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:placetalk/src/blocs/AuthBlocs/auth_bloc.dart';
import 'package:placetalk/src/blocs/BoardBlocs/board_bloc.dart';
import 'package:placetalk/src/blocs/JoinBlocs/join_bloc.dart';
import 'package:placetalk/src/models/UserModel.dart';

import '../blocs/PlaceBlocs/place_bloc.dart';
import '../components/CustomDialog.dart';
import 'routes/routes.gr.dart';

@RoutePage()
class JoinScreen extends StatelessWidget {
  const JoinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '참여 중인 게시판',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        leading: const AutoLeadingButton(),
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
        builder: (context, authState) {
          late UserModel user;
          if (authState is AuthGranted) {
            user = authState.user;
          }
          return BlocListener<BoardBloc, BoardState>(
            listener: (context, state) {
              if (state is BoardJoinLoading) {
                BlocProvider.of<JoinBloc>(context)
                    .add(FetchJoinDataEvent(user.kakaoID));
              }
            },
            child: BlocBuilder<JoinBloc, JoinState>(
              builder: (context, state) {
                if (state is JoinInitial) {
                  BlocProvider.of<JoinBloc>(context)
                      .add(FetchJoinDataEvent(user.kakaoID));
                  return const Center(child: CircularProgressIndicator());
                } else if (state is JoinLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is JoinLoaded) {
                  return Container(
                    margin: const EdgeInsets.only(top: 15),
                    padding: const EdgeInsets.all(10),
                    child: state.itemsLatLng.isEmpty
                        ? const Center(
                            child: Text(
                            '참여 중인 게시판이 없어요',
                            style: TextStyle(
                                color: Color(0xffadadad),
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ))
                        : ListView.separated(
                            itemCount: state.itemsLatLng.length,
                            itemBuilder: ((BuildContext context, index) {
                              var item = state.itemsLatLng[
                                  state.itemsLatLng.keys.toList()[index]];

                              return ListTile(
                                leading: Icon(
                                  Icons.bookmark_rounded,
                                  size: 28,
                                  color: item!['state'] == 0
                                      ? const Color(0xff82E3CD)
                                      : const Color(0xffFF7D7D),
                                ),
                                title: GestureDetector(
                                  onTap: () {
                                    context.router.root.push(HomeRoute(
                                      position: NLatLng(
                                        item['latitude'],
                                        item['longitude'],
                                      ),
                                    ));

                                    BlocProvider.of<PlaceBloc>(context).add(
                                      const FetchNaverMapDataEvent(),
                                    );
                                  },
                                  child: Text(
                                    state.itemsLatLng.keys.toList()[index],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
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
                                    const SizedBox(height: 5),
                                    Text(
                                      item['state'] == 0
                                          ? '상시'
                                          : '${DateFormat('M.d').format(item['startDate'])}~${DateFormat('M.d').format(item['endDate'])}',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xffadadad),
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(width: 10),
                                    InkWell(
                                      onTap: () {
                                        BlocProvider.of<BoardBloc>(context).add(
                                            FetchBoardData(item['place_id']));

                                        context.router.push(
                                          BoardEventRoute(
                                            name: item['name'],
                                            placeID: item['place_id'],
                                          ),
                                        );
                                      },
                                      child: const Icon(
                                        Icons.chat_bubble_outline_outlined,
                                        size: 32,
                                        color: Color(0xffa5a5a5),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    InkWell(
                                      onTap: () {
                                        context.router.push(
                                          EventTabRoute(
                                            name: item['name'],
                                            placeID: item['place_id'],
                                            children: [
                                              InformEventRoute(
                                                name: item['name'],
                                                placeID: item['place_id'],
                                              ),
                                            ],
                                          ),
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
                            separatorBuilder:
                                (BuildContext context, int index) => Divider(
                              thickness: .5,
                              color: const Color(0xff707070).withOpacity(.6),
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
            ),
          );
        },
      ),
    );
  }
}
