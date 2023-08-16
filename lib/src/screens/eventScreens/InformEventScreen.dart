import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:placetalk/src/blocs/BoardBlocs/board_bloc.dart';
import 'package:placetalk/src/blocs/PlaceInfoblocs/place_info_bloc.dart';
import '../../repositories/SessionRepo.dart';
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
        child: BlocBuilder<PlaceInfoBloc, PlaceInfoState>(
            builder: (context, state) {
          if (state is PlaceInfoInitial) {
            return const SizedBox.shrink();
          } else if (state is PlaceInfoLoading) {
            return const CircularProgressIndicator();
          } else if (state is PlaceInfoLoaded) {
            String item =
                state.items[state.items.keys.toList()[0]].keys.toList()[0];

            var items = state.items[state.items.keys.toList()[0]][item];

            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      width: 90,
                      height: 85,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        image: DecorationImage(
                          image: NetworkImage(SessionRepo()
                              .getImageUrl(items['images'][0]['image_id'])),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 150,
                          child: Text(
                            items['name'],
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Text(
                          '${DateFormat('M.d').format(items['startDate'])}~${DateFormat('M.d').format(items['endDate'])}',
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
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
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
                const SizedBox(height: 30),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    itemCount: state.placeInfoList.length,
                    itemBuilder: (BuildContext context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: 100,
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17),
                              color: const Color(0xff82E3CD),
                            ),
                            child: Text(
                              state.placeInfoList[index].title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Markdown(
                            data: state.placeInfoList[index].content,
                            shrinkWrap: true,
                            selectable: false,
                          )
                        ],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        color: Color(0xff707070),
                        thickness: .5,
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text('데이터 불러오기에 실패했어요'));
          }
        }),
      ),
      floatingActionButton: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // 둥근 모서리 설정
        ),
        onPressed: () {
          BlocProvider.of<BoardBloc>(context).add(ToJoinEvnet(placeID!));

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
