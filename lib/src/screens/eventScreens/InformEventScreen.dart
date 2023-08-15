import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: unused_import
import '../../components/CustomButtons.dart';
import '../routes/routes.gr.dart';

@RoutePage()
class InformEventScreen extends StatelessWidget {
  const InformEventScreen({super.key, this.placeID, this.name});

  final int? placeID;
  final String? name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: 90,
                  height: 95,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.amber,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '축제명',
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '기간',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xffadadad),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    OutlinedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(horizontal: 12),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xffFF7D7D),
                        ), // 배경색 설정
                        side: MaterialStateProperty.all(BorderSide.none),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(16), // 둥근 모서리 설정
                          ),
                        ),
                      ),
                      child: const Text(
                        '예매하기',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Divider(
              thickness: .5,
              color: const Color(0xff707070).withOpacity(.63),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // 둥근 모서리 설정
        ),
        onPressed: () {
          context.navigateTo(
            EventsRouter(
              children: [
                EventsBoardRouter(
                  children: [
                    BoardEventRoute(name: name!, placeID: placeID!),
                  ],
                ),
              ],
            ),
          );
        }, //POST /api/places/:place_id/booth
        label: Text(
          '게시판 입장',
          style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
        backgroundColor: Colors.amber,
        elevation: 4,
        icon: Image.asset(
          'assets/images/join.png',
          color: Colors.white,
          width: 24,
          height: 24,
        ),
      ),
    );
  }
}
