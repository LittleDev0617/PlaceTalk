import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:placetalk/src/blocs/FeedBlocs/feed_bloc.dart';

@RoutePage()
class NoticeEventScreen extends StatelessWidget {
  const NoticeEventScreen({super.key, this.placeID, this.name});

  final int? placeID;
  final String? name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: BlocBuilder<FeedBloc, FeedState>(builder: (context, state) {
        if (state is FeedInitial) {
          BlocProvider.of<FeedBloc>(context).add(FetchEventFeedData(placeID!));
          return const SizedBox.shrink();
        } else if (state is FeedLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FeedLoaded) {
          return ListView.builder(
            itemCount: state.feedList.length,
            itemBuilder: ((BuildContext context, index) {
              return SizedBox(
                child: GestureDetector(
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
                        title: Text(
                          state.feedList[index].nickname,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () {},
                          iconSize: 24,
                          icon: const Icon(
                            Icons.more_vert,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.feedList[index].content,
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
                              itemCount: state.feedList[index].images.length,
                              itemBuilder: (((BuildContext context, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          'http://125.180.98.19:1234/images/${state.feedList[index].images[index].imageId}'),
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
                            state.feedList[index].writeTime,
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
                ),
              );
            }),
          );
        } else {
          return const Center(child: Text('데이터 불러오기에 실패했어요.'));
        }
      }),
    );
  }
}
