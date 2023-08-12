import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:placetalk/src/screens/routes/routes.gr.dart';

import '../blocs/ExploreBlocs/explore_bloc.dart';

@RoutePage()
class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          '인기장소 둘러보기',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            color: const Color(0xffff7d7d),
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
        backgroundColor: const Color(0xfff7f7f7),
        elevation: 0,
      ),
      body: Stack(
        alignment: Alignment.topRight,
        children: [
          const PlaceCardPage(),
          Container(
            width: 80,
            height: 30,
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '인기 순',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Colors.black,
                  size: 18,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PlaceCardPage extends StatefulWidget {
  const PlaceCardPage({super.key});

  @override
  _PlaceCardPageState createState() => _PlaceCardPageState();
}

class _PlaceCardPageState extends State<PlaceCardPage> {
  final PageController _pageController = PageController(viewportFraction: 0.8);
  double _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page ?? 0;
      });
    });
  }

  void _onPageChanged(int index) {
    if (_pageController.page != index.toDouble()) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreBloc, ExploreState>(
      builder: (context, state) {
        if (state is ExploreInitial) {
          BlocProvider.of<ExploreBloc>(context).add(
            FetchExploreDataEvent(),
          );
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ExploreLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ExploreLoaded) {
          return PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            itemCount: state.datas.length,
            onPageChanged: _onPageChanged,
            itemBuilder: (BuildContext context, int index) {
              String item = state.datas.keys.toList()[index];
              double delta = index - _currentPage;

              if (delta > 0) {
              } else {}

              double translateY = delta * 15;

              return Center(
                child: GestureDetector(
                  onTap: () {
                    context.router.push(
                      HomeRoute(
                        position: NLatLng(
                          state.datas[item]['latitude'],
                          state.datas[item]['longitude'],
                        ),
                      ),
                    );
                  },
                  child: Transform.translate(
                    offset: Offset(0, translateY),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(25),
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text(
                              '분류',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              state.datas.keys.toList()[index],
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '${DateFormat('M.d').format(state.datas[item]!['startDate'])}~${DateFormat('M.d').format(state.datas[item]!['endDate'])}',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(
            child: Text(
              '데이터 불러오기에 실패했어요',
            ),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
