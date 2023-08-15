import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class BoardWriteEventScreen extends StatefulWidget {
  final String name;
  const BoardWriteEventScreen({
    super.key,
    required this.name,
  });

  @override
  State<BoardWriteEventScreen> createState() => _BoardWriteEventScreenState();
}

class _BoardWriteEventScreenState extends State<BoardWriteEventScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _myFocusNode = FocusNode();

  String _inputText = '';

  void _sendMessage() {
    setState(() {
      _inputText = _textEditingController.text;
      if (_inputText.trim().isNotEmpty) {
        _textEditingController.clear();
        FocusScope.of(context).unfocus();

        const snackBar = SnackBar(
          content: Text('작성 되었습니다.'),
        );

        context.router.pop();

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        const snackBar = SnackBar(
          content: Text('내용을 입력하세요'),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

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
        backgroundColor: const Color(0xfff7f7f7),
        centerTitle: true,
        leading: const AutoLeadingButton(color: Colors.black),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
        color: Colors.white,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: const Color(0xff707070).withOpacity(.4),
                  ),
                ),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.only(
                    top: 12, left: 6, right: 6, bottom: 6),
                leading: const CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage(
                    'assets/images/profile.png',
                  ),
                ),
                title: Text(
                  '익명',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Expanded(
              child: TextField(
                controller: _textEditingController,
                focusNode: _myFocusNode,
                expands: true,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: '내용을 입력해주세요',
                  hintStyle: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withOpacity(0.3),
                  ),
                  border: InputBorder.none, // 테두리 없애기
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xffFF7D7D)), // 배경색 설정
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(16.0), // border-radius 설정
                    ),
                  ),
                ),
                onPressed: () {
                  _sendMessage();
                },
                child: const Text(
                  '게시',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   backgroundColor: const Color(0xffff7d7d),
      //   isExtended: true,
      //   elevation: 0,
      //   onPressed: () {
      //     _sendMessage();
      //   },
      //   label: const Text(
      //     '게시',
      //     style: TextStyle(color: Colors.white),
      //   ),
      // ),
    );
  }
}
