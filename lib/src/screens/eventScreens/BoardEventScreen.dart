import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:placetalk/src/blocs/BoardBlocs/board_bloc.dart';
import 'package:placetalk/src/blocs/CommentBlocs/comment_bloc.dart';
import 'package:placetalk/src/components/CustomButtons.dart';
import 'package:placetalk/src/screens/routes/routes.gr.dart';

import '../../blocs/AuthBlocs/auth_bloc.dart';
import '../../components/CustomDialog.dart';

@RoutePage()
class BoardEventScreen extends StatefulWidget {
  final int placeID;
  final String name;
  const BoardEventScreen({
    super.key,
    @PathParam('placeID') required this.placeID,
    required this.name,
  });

  @override
  State<BoardEventScreen> createState() => _BoardEventScreenState();
}

class _BoardEventScreenState extends State<BoardEventScreen> {
  bool _isLatestOrder = false; // 초기 값 0

  void _toggleOrder() {
    setState(() {
      BlocProvider.of<BoardBloc>(context).add(
        FetchLikeOrderData(widget.placeID, _isLatestOrder == false ? 1 : 0),
      );
      _isLatestOrder = !_isLatestOrder; // 값 토글
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // FloatingActionButton(
          //   backgroundColor: Colors.white.withOpacity(.9),
          //   onPressed: () {},
          //   shape: const CircleBorder(),
          //   elevation: 3,
          //   child: const SizedBox(
          //     height: 60,
          //     width: 60,
          //     child: Icon(
          //       Icons.map_outlined, //
          //       color: Color(0xffff7d7d),
          //       size: 32,
          //     ),
          //   ),
          // ),
          const SizedBox(height: 15),
          FloatingActionButton(
            backgroundColor: const Color(0xffFF7D7D),
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
                color: Colors.white,
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
        leading: const AutoLeadingButton(color: Colors.black),
      ),
      body: BlocBuilder<BoardBloc, BoardState>(
        builder: (context, state) {
          if (state is BoardJoinLoading) {
            if (state.codes == 0 || state.codes == 1) {
              BlocProvider.of<BoardBloc>(context)
                  .add(FetchBoardData(widget.placeID));
            } else if (state.codes == 2) {
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                _showBottomModal(context);
              });

              return const Center(
                child: Text("참여 중인 핫플이 5개를 초과했습니다."),
              );
            }
            return const Center(child: CircularProgressIndicator());
          } else if (state is BoardInitial) {
            BlocProvider.of<BoardBloc>(context)
                .add(FetchBoardData(widget.placeID));
            return const SizedBox.shrink();
          } else if (state is BoardLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BoardLoaded) {
            int? userID;

            return BlocListener<AuthBloc, AuthState>(
              listener: (context, authstate) {
                if (authstate is AuthGranted) {
                  userID = authstate.user.kakaoID;
                }
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.local_fire_department,
                                  color: Color(0xffFF7D7D), // 여기가 검색부분임
                                  size: 21,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  '현재 핫플의 실시간 플레이스 톡입니다',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
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
                            _isLatestOrder ? '좋아요 순' : '최신 순',
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
                        itemCount: state.boards.length,
                        itemBuilder: ((BuildContext context, index) {
                          return SizedBox(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  onTap: () {
                                    BlocProvider.of<CommentBloc>(context).add(
                                      FetchCommentsEvent(
                                        state.boards[index].postId,
                                      ),
                                    );
                                    context.router.push(
                                      BoardDetailEventRoute(
                                        name: widget.name,
                                        postID: state.boards[index].postId,
                                        commentCnt:
                                            state.boards[index].commentCnt,
                                        content: state.boards[index].content,
                                        createDate:
                                            state.boards[index].createDate,
                                        nickname:
                                            state.boards[index].user.nickname,
                                        likeCnt: state.boards[index].likes,
                                        isPressLike:
                                            state.boards[index].isPressLike,
                                      ),
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
                                        state.boards[index].user.nickname,
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const Spacer(),
                                      if (userID ==
                                          state.boards[index].user.userId)
                                        IconButton(
                                          onPressed: () {},
                                          iconSize: 24,
                                          icon: const Icon(
                                            Icons.more_horiz,
                                            color: Colors.black,
                                          ),
                                        ),
                                    ],
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 180,
                                        child: Text(
                                          state.boards[index].content,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            state.boards[index].createDate,
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w300,
                                              color:
                                                  Colors.black.withOpacity(.56),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              CustomIconText(
                                                icons: const Icon(
                                                  Icons
                                                      .favorite_border_outlined,
                                                  color: Colors.black,
                                                ),
                                                text:
                                                    '${state.boards[index].likes}',
                                              ),
                                              const SizedBox(width: 15),
                                              CustomIconText(
                                                icons: const Icon(
                                                  Icons.chat_bubble_outline,
                                                  color: Colors.black,
                                                ),
                                                text:
                                                    '${state.boards[index].commentCnt}',
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
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(
                          thickness: 1,
                          color: const Color(0xff707070).withOpacity(.3),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text('데이터 불러오기에 실패했어요.'));
          }
        },
      ),
    );
  }
}

void _showBottomModal(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: Container(
          margin: const EdgeInsets.only(
            left: 25,
            right: 25,
            bottom: 40,
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "참여 중인 핫플이 5개를 초과했습니다.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  context.back();
                },
                child: const Text(
                  '닫기',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xffadadad),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
