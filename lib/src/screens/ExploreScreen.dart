import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:placex/src/blocs/Exploreblocs/explore_bloc.dart';
import 'package:placex/src/screens/routes/app_router.dart.gr.dart';

import '../blocs/boothBlocs/booth_bloc.dart';
import '../components/buttons.dart';

@RoutePage()
class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ExplorePage();
  }
}

class ExplorePage extends StatelessWidget {
  const ExplorePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          '인기 장소 둘러보기',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 9),
            child: CircleAvatarIconButton(
              iconSize: 27,
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
      body: StackedCardPage(),
    );
  }
}

class StackedCardPage extends StatefulWidget {
  @override
  _StackedCardPageState createState() => _StackedCardPageState();
}

class _StackedCardPageState extends State<StackedCardPage> {
  PageController _pageController = PageController(viewportFraction: 0.8);
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
    return BlocBuilder<ExploreBloc, ExploreBloceState>(
      builder: (context, state) {
        if (state is ExploreInitial) {
          BlocProvider.of<ExploreBloc>(context).add(
            FetchExploreDataEvent(),
          );
          return const Padding(
            padding: EdgeInsets.all(15.0),
            child: CircularProgressIndicator(),
          );
        } else if (state is ExploreDataLoading) {
          return const Padding(
            padding: EdgeInsets.all(15.0),
            child: CircularProgressIndicator(),
          );
        } else if (state is ExploreDataLoaded) {
          List<String> names = state.datas.keys.toList();
          List<Map<String, dynamic>> dateRanges =
              state.datas.values.map((value) {
            return {
              'start_date': value['start_date'] ?? '',
              'end_date': value['end_date'] ?? '',
            };
          }).toList();

          List<Map<String, double>> latlong = state.datas.values.map((value) {
            double latitude = value['latitude'];
            double longitude = value['longitude'];

            return {
              'latitude': latitude,
              'longitude': longitude,
            };
          }).toList();
          return PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            itemCount: state.datas.length,
            onPageChanged: _onPageChanged,
            itemBuilder: (BuildContext context, int index) {
              double delta = index - _currentPage;

              if (delta > 0) {
              } else {}

              double translateY = delta * 20;

              return Center(
                child: GestureDetector(
                  onTap: () {
                    AutoRouter.of(context).push(const HomeRoute());
                    BlocProvider.of<BoothBloc>(context).add(
                      PopBoothDataEvent(
                        NLatLng(
                          latlong[index]['latitude']!,
                          latlong[index]['longitude']!,
                        ),
                      ),
                    );
                  },
                  child: Transform.translate(
                    offset: Offset(0, translateY),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text('분류', style: TextStyle(fontSize: 18)),
                            Text(
                              names[index],
                              style: const TextStyle(
                                fontSize: 22,
                                letterSpacing: -1,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '${dateRanges[index]['start_date']} ~ ${dateRanges[index]['end_date']}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                letterSpacing: -1.5,
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
          return const SizedBox.shrink();
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
