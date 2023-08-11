import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:placex/src/blocs/JoinBlocs/join_bloc.dart';

import '../components/buttons.dart';

@RoutePage()
class JoinScreen extends StatelessWidget {
  const JoinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return JoinPage();
  }
}

class JoinPage extends StatelessWidget {
  const JoinPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          '참여중인 장소',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: CircleAvatarIconButton(
              iconSize: 18,
              backgroundColor: Colors.transparent,
              iconColor: Colors.black,
              icon: Icons.ios_share_outlined,
              onPressed: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 9),
            child: CircleAvatarIconButton(
              iconSize: 24,
              backgroundColor: Colors.transparent,
              iconColor: const Color(0xffFF7D7D),
              icon: Icons.notifications_outlined,
              onPressed: () {},
            ),
          ),
        ],
        backgroundColor: const Color(0xffF7F7F7),
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Center(
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
              return Container(
                padding: const EdgeInsets.all(20),
                child: ListView.builder(
                  itemCount: namesList.length, // 생성할 아이템의 개수
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        ListTile(
                          title: Text(
                            namesList[index],
                            style: const TextStyle(
                              letterSpacing: -1,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '18:00~21:00',
                                style: const TextStyle(
                                  letterSpacing: -1,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${dateRanges[index]['start_date']}~${dateRanges[index]['end_date']}',
                                    style: const TextStyle(
                                      letterSpacing: -1,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CircleAvatarIconButton(
                                        iconSize: 18,
                                        backgroundColor: Colors.transparent,
                                        iconColor: Colors.black87,
                                        icon: Icons.chat_bubble_outline,
                                        onPressed: () {},
                                      ),
                                      CircleAvatarIconButton(
                                        iconSize: 18,
                                        backgroundColor: Colors.transparent,
                                        iconColor: Colors.black87,
                                        icon: Icons.assignment_outlined,
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          trailing: Container(
                            width: 70,
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                        Divider(
                          thickness: .5,
                          color: Color(0xff707070).withOpacity(.6),
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
    );
  }
}
