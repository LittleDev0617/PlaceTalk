import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:placetalk/src/repositories/SessionRepo.dart';
import 'package:placetalk/src/screens/routes/routes.gr.dart';

import '../blocs/FeedBlocs/feed_bloc.dart';
import '../components/CustomDialog.dart';

@RoutePage()
class NoticeScreen extends StatelessWidget {
  const NoticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '전체 피드',
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
      body: Container(
        padding: const EdgeInsets.all(24),
        child: BlocBuilder<FeedBloc, FeedState>(
          builder: (context, state) {
            if (state is FeedInitial) {
              BlocProvider.of<FeedBloc>(context).add(FetchFeedData());
              return const SizedBox.shrink();
            } else if (state is FeedLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FeedLoaded) {
              return ListView.builder(
                itemCount: state.feedList.length,
                itemBuilder: ((BuildContext context, feedindex) {
                  return SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 0),
                          leading: const CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage: AssetImage(
                              'assets/images/profile.png',
                            ),
                          ),
                          title: InkWell(
                            onTap: () {
                              context.navigateTo(
                                EventsRouter(
                                  children: [
                                    EventTabRoute(
                                      name: state.feedList[feedindex].nickname,
                                      placeID:
                                          state.feedList[feedindex].placeId,
                                      children: [
                                        NoticeEventRoute(
                                          name: state
                                              .feedList[feedindex].nickname,
                                          placeID:
                                              state.feedList[feedindex].placeId,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                              // BlocProvider.of<PlaceInfoBloc>(context).add(
                              //   FetchPlaceInfoData(
                              //       state.feedList[feedindex].placeId),
                              // );
                              // context.router.navigate(
                              //   EventsRouter(
                              //     children: [
                              //       EventTabRoute(
                              //         placeID:
                              //             state.feedList[feedindex].placeId,
                              //         name: state.feedList[feedindex].nickname,
                              //       )
                              //     ],
                              //   ),
                              // );
                              // context.router.pushAll([
                              //   const EventsRouter(),
                              //   EventTabRoute(
                              // placeID: state.feedList[feedindex].placeId,
                              // name: state.feedList[feedindex].nickname,
                              //   ),
                              // ]);
                            },
                            child: Text(
                              state.feedList[feedindex].nickname,
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.feedList[feedindex].content,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                              height: 130,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount:
                                    state.feedList[feedindex].images.length,
                                itemBuilder: (((BuildContext context, index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          SessionRepo().getImageUrl(state
                                              .feedList[feedindex]
                                              .images[index]
                                              .imageId),
                                        ),
                                      ),
                                    ),
                                    margin: const EdgeInsets.only(right: 5),
                                    child:
                                        const AspectRatio(aspectRatio: 16 / 13),
                                  );
                                })),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              state.feedList[feedindex].writeTime,
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.black.withOpacity(.46),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 35),
                      ],
                    ),
                  );
                }),
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
