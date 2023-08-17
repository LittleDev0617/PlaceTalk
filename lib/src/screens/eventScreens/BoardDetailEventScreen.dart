import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:placetalk/src/blocs/CommentBlocs/comment_bloc.dart';
import 'package:placetalk/src/components/CustomButtons.dart';

import '../../components/CustomDialog.dart';
import '../../repositories/SessionRepo.dart';

@RoutePage()
class BoardDetailEventScreen extends StatefulWidget {
  final int postID;
  final String name;
  final String content;
  final String createDate;
  final int commentCnt;
  final int likeCnt;
  final bool isPressLike;
  final String nickname;

  const BoardDetailEventScreen(
      {super.key,
      required this.name,
      required this.content,
      required this.createDate,
      required this.commentCnt,
      required this.isPressLike,
      required this.likeCnt,
      required this.nickname,
      @PathParam('postID') required this.postID});

  @override
  State<BoardDetailEventScreen> createState() => _BoardDetailEventScreenState();
}

class _BoardDetailEventScreenState extends State<BoardDetailEventScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _myFocusNode = FocusNode();

  String _inputText = '';

  @override
  void initState() {
    BlocProvider.of<CommentBloc>(context).add(
      FetchCommentsEvent(
        widget.postID,
      ),
    );
    // TODO: implement initState
    super.initState();
  }

  void _sendMessage() {
    setState(() async {
      _inputText = _textEditingController.text;
      if (_inputText.trim().isNotEmpty) {
        Map data = {
          'post_id': widget.postID,
          'is_reply': 0,
          'reply_id': 0,
          'content': _inputText
        };
        await SessionRepo().post('api/comments', data);
        _textEditingController.clear();
        FocusScope.of(context).unfocus();
        selectedCommentIndex = -1;
        BlocProvider.of<CommentBloc>(context)
            .add(FetchCommentsEvent(widget.postID));
      } else {
        const snackBar = SnackBar(
          content: Text('내용을 입력하세요'),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

  void _setFocusAndShowKeyboard() {
    // Set focus to the specified element
    _myFocusNode.requestFocus();

    // Show the keyboard
    FocusScope.of(context).requestFocus(_myFocusNode);
  }

  int selectedCommentIndex = -1;

  @override
  void dispose() {
    _myFocusNode.dispose();
    _textEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            BlocProvider.of<CommentBloc>(context)
                .add(FetchCommentsEvent(widget.postID));
          });
        },
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              ListTile(
                contentPadding:
                    const EdgeInsets.only(top: 24, left: 24, right: 24),
                leading: const CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage(
                    'assets/images/profile.png',
                  ),
                ),
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.nickname,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          widget.createDate,
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w300,
                            color: Colors.black.withOpacity(.29),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      iconSize: 28,
                      icon: const Icon(
                        Icons.more_horiz,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 5,
                      child: Text(
                        widget.content,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomIconTextButton(
                            iconButton: InkWell(
                              onTap: () {},
                              child: Icon(
                                Icons.favorite_border_outlined,
                                color: widget.isPressLike
                                    ? const Color(0xffFF7D7D)
                                    : Colors.black,
                              ),
                            ),
                            text: '${widget.likeCnt}',
                          ),
                          const SizedBox(width: 15),
                          CustomIconText(
                            icons: const Icon(
                              Icons.chat_bubble_outline,
                              color: Colors.black,
                            ),
                            text: '${widget.commentCnt}',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 10,
                color: const Color(0xffF1F1F1),
              ),
              Expanded(
                child: BlocBuilder<CommentBloc, CommentState>(
                  builder: (context, state) {
                    if (state is CommentInitial) {
                      return const SizedBox.shrink();
                    } else if (state is CommentLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is CommentLoaded) {
                      return ListView.separated(
                        itemCount: state.comments.length,
                        shrinkWrap: true,
                        itemBuilder: ((BuildContext context, index) {
                          return Container(
                            color: selectedCommentIndex == index
                                ? const Color(0xffEEF1F6)
                                : Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  contentPadding: const EdgeInsets.only(
                                      left: 24, right: 24, top: 12, bottom: 5),
                                  leading: const CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    backgroundImage: AssetImage(
                                      'assets/images/profile.png',
                                    ),
                                  ),
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        state.comments[index].user.nickname,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          CustomIconTextButton(
                                            iconButton: InkWell(
                                              onTap: () {},
                                              child: const Icon(
                                                Icons.favorite_border_outlined,
                                                color: Colors.black,
                                              ),
                                            ),
                                            text:
                                                '${state.comments[index].likes}',
                                          ),
                                          const SizedBox(width: 15),
                                          CustomIconTextButton(
                                            iconButton: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  selectedCommentIndex = index;
                                                  _setFocusAndShowKeyboard();
                                                });
                                              },
                                              child: const Icon(
                                                Icons
                                                    .chat_bubble_outline_rounded,
                                                color: Colors.black,
                                              ),
                                            ),
                                            text: '',
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 24,
                                    right: 24,
                                    bottom: 12,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        state.comments[index].content,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        state.comments[index].createDate,
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black.withOpacity(.3),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(
                          thickness: 1,
                          color: const Color(0xff707070).withOpacity(.3),
                        ),
                      );
                    } else {
                      return const Center(child: Text('데이터 불러오기를 실패했어요.'));
                    }
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .8,
                child: TextField(
                  focusNode: _myFocusNode,
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: '댓글을 입력하세요',
                    hintStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xffd7dadc),
                    ),
                    suffixIcon: InkWell(
                      onTap: _sendMessage,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 8, top: 8, bottom: 8),
                        child: SvgPicture.asset(
                          'assets/images/send.svg',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
