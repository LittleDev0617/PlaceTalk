import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:placetalk/src/blocs/PlaceBlocs/place_bloc.dart';
import 'package:placetalk/src/components/CustomButtons.dart';
import 'package:placetalk/src/screens/routes/routes.gr.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  final NLatLng? position;
  HomeScreen({super.key, this.position});

  late NaverMapController _controller;

  @override
  Widget build(BuildContext context) {
    return BlocListener<PlaceBloc, PlaceState>(
      listener: (context, state) {
        if (state is LocationPermissionDenied ||
            state is LocationPermissionUnknown) {
          showBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return const Center(
                child: Text('위치 권한을 허용해 주세요'),
              );
            },
          );
        }
      },
      child: BlocBuilder<PlaceBloc, PlaceState>(
        builder: (context, state) {
          if (state is PlaceInitial) {
            BlocProvider.of<PlaceBloc>(context).add(
              RequestLocationPermission(),
            );
            BlocProvider.of<PlaceBloc>(context).add(
              FetchNaverMapDataEvent(),
            );
            return const NaverMap();
          } else if (state is PlaceLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PlaceLoaded) {
            return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: Colors.transparent,
                title: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.all(12),
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomDropdownButton(
                          itemList: state.itemsLatLng,
                          customOnChanged: (value) {
                            WidgetsBinding.instance.addPostFrameCallback(
                              (_) {
                                _controller.updateCamera(
                                  NCameraUpdate.withParams(
                                    target: NLatLng(
                                      state.itemsLatLng[value]!['latitude'],
                                      state.itemsLatLng[value]!['longitude'],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.notifications_outlined,
                          color: Color(0xffff7d7d),
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: Size(
                    MediaQuery.of(context).size.width,
                    40,
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    height: 30,
                    margin: const EdgeInsets.symmetric(horizontal: 19.5),
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: ((BuildContext context, index) {
                        List<String> items = [
                          '콘서트',
                          '페스티벌',
                          '지역축제',
                          '대학축제',
                          '팝업스토어'
                        ];

                        List<String> icons = [
                          'assets/images/concert.png',
                          'assets/images/festival.png',
                          'assets/images/local.png',
                          'assets/images/univ.png',
                          'assets/images/store.png'
                        ];

                        return Container(
                          margin: const EdgeInsets.only(right: 5),
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(icons[index], width: 17),
                              Text(
                                items[index],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
              body: NaverMap(
                onMapReady: (controller) async {
                  _controller = controller;

                  for (NMarker marker in state.markers) {
                    int index = state.markers.toList().toList().indexOf(marker);
                    marker.setOnTapListener(
                      (overlay) {
                        // AutoRouter.of(context).parent<TabsRouter>()!.navigate(
                        //       EventsRouter(
                        //         children: [
                        //           EventLandingRoute(
                        //             eventID: index,
                        //             name:
                        //                 state.itemsLatLng.keys.toList()[index],
                        //             children: const [
                        //               InformEventRoute(),
                        //             ],
                        //           ),
                        //         ],
                        //       ),
                        //     );

                        context.router.push(HomeEventRoute(
                          position: marker.position,
                          eventID: index,
                          name: state.itemsLatLng.keys.toList()[index],
                        ));
                      },
                    );

                    marker.setIcon(const NOverlayImage.fromAssetImage(
                        'assets/images/always_marker.png'));
                    marker.setSize(const Size(40, 54));
                  }

                  controller.addOverlayAll(state.markers);
                },
                options: NaverMapViewOptions(
                  locationButtonEnable: true,
                  initialCameraPosition: NCameraPosition(
                      target: position ??
                          const NLatLng(37.54388827708887, 127.07596063613892),
                      zoom: 14.5),
                ),
              ),
            );
          } else {
            return const Center(
              child: Text(
                '데이터 불러오기에 실패했어요',
              ),
            );
          }
        },
      ),
    );
  }
}
