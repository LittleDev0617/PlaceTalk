import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:placetalk/src/components/CustomButtons.dart';

@RoutePage()
class BoardDetailEventScreen extends StatefulWidget {
  final int postID;
  final String name;
  const BoardDetailEventScreen({
    super.key,
    required this.name,
    @PathParam('postID') required this.postID,
  });

  @override
  State<BoardDetailEventScreen> createState() => _BoardDetailEventScreenState();
}

class _BoardDetailEventScreenState extends State<BoardDetailEventScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _myFocusNode = FocusNode();

  String _inputText = '';

  void _sendMessage() {
    setState(() {
      _inputText = _textEditingController.text;
      if (_inputText.trim().isNotEmpty) {
        _textEditingController.clear();
        FocusScope.of(context).unfocus();
        selectedCommentIndex = -1;
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
                        '익명',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '작성일자',
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
                      Icons.more_vert,
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
                      '저는 내일 광진구쪽으로 가보려고용 그쪽에 재밌는거 많다고 하더라고요 친목하기도 좋구',
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
                            child: const Icon(
                              Icons.favorite_border_outlined,
                              color: Colors.black,
                            ),
                          ),
                          text: '4',
                        ),
                        const SizedBox(width: 15),
                        const CustomIconText(
                          icons: Icon(
                            Icons.chat_bubble_outline,
                            color: Colors.black,
                          ),
                          text: '4',
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
              child: ListView.separated(
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                '익명',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  CustomIconTextButton(
                                    iconButton: InkWell(
                                      onTap: () {},
                                      child: const Icon(
                                        Icons.favorite_border_outlined,
                                        color: Colors.black,
                                      ),
                                    ),
                                    text: '4',
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
                                        Icons.chat_bubble_outline_rounded,
                                        color: Colors.black,
                                      ),
                                    ),
                                    text: '4',
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '내용',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                '작성일자',
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
                separatorBuilder: (BuildContext context, int index) => Divider(
                  thickness: 1,
                  color: const Color(0xff707070).withOpacity(.3),
                ),
                itemCount: 10,
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
    );
  }
}
