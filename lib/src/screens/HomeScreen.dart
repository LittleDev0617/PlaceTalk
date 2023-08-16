import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:placetalk/src/blocs/NearBloc/near_bloc.dart';
import 'package:placetalk/src/blocs/PlaceBlocs/place_bloc.dart';
import 'package:placetalk/src/components/CustomButtons.dart';
import 'package:placetalk/src/screens/routes/routes.gr.dart';

import '../blocs/BoothBlocs/booth_bloc.dart';
import '../components/CustomDialog.dart';

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
      child: Scaffold(
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
            child: BlocBuilder<NearBloc, NearState>(
              builder: (context, nearstate) {
                if (nearstate is NearInitial) {
                  BlocProvider.of<NearBloc>(context).add(
                    FetchNearMapDataEvent(),
                  );

                  return const SizedBox.shrink();
                } else if (nearstate is NearLoding) {
                  return const CircularProgressIndicator();
                } else if (nearstate is NearLoaded) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (nearstate.itemsLatLng.isNotEmpty)
                        Expanded(
                          child: CustomDropdownButton(
                            itemList: nearstate.itemsLatLng,
                            customOnChanged: (value) async {
                              final Map<String, dynamic>? selectedItem =
                                  nearstate.itemsLatLng[value];
                              if (selectedItem != null) {
                                final double latitude =
                                    selectedItem['latitude'];
                                final double longitude =
                                    selectedItem['longitude'];

                                _controller.updateCamera(
                                  NCameraUpdate.withParams(
                                    target: NLatLng(latitude, longitude),
                                    zoom: 14,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      if (nearstate.itemsLatLng.isEmpty)
                        const Padding(
                          padding: EdgeInsets.all(12),
                          child: Text(
                            "내 주변 핫플이 없어요 😂",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Color(0xffadadad),
                            ),
                          ),
                        ),
                      IconButton(
                        icon: const Icon(
                          Icons.notifications_outlined,
                          color: Color(0xffff7d7d),
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: ((BuildContext context) {
                                return const CustomAlertDialog();
                              }));
                        },
                      ),
                    ],
                  );
                } else {
                  return const Center(child: Text('데이터 불러오기를 실패했습니다.'));
                }
              },
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
              margin: const EdgeInsets.symmetric(horizontal: 12),
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                itemBuilder: ((BuildContext context, index) {
                  List<String> items = [
                    '여가',
                    '복합문화공간',
                    '콘서트',
                    '페스티벌',
                    '지역 축제',
                    '대학 축제',
                    '팝업스토어',
                  ];

                  List<String> icons = [
                    'assets/images/leisure.png',
                    'assets/images/space.png',
                    'assets/images/concert.png',
                    'assets/images/festival.png',
                    'assets/images/local.png',
                    'assets/images/univ.png',
                    'assets/images/store.png',
                  ];

                  return Container(
                    margin: const EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: InkWell(
                      onTap: () async {
                        final camPosition =
                            await _controller.getCameraPosition();

                        BlocProvider.of<PlaceBloc>(context).add(
                          FetchCategoryMapDataEvent(
                            category: items[index],
                            position: camPosition,
                          ),
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(icons[index], width: 17),
                          const SizedBox(width: 6),
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
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
        body: BlocBuilder<PlaceBloc, PlaceState>(
          builder: (context, state) {
            if (state is PlaceInitial) {
              BlocProvider.of<PlaceBloc>(context).add(
                const FetchNaverMapDataEvent(),
              );
              return const NaverMap();
            } else if (state is PlaceLoading) {
              return Stack(children: [
                NaverMap(
                  options: NaverMapViewOptions(
                      initialCameraPosition: state.position),
                ),
                const Center(child: CircularProgressIndicator()),
              ]);
            } else if (state is PlaceLoaded) {
              return NaverMap(
                onMapTapped: (point, latLng) async {
                  BlocProvider.of<PlaceBloc>(context).add(
                      FetchNaverMapDataEvent(
                          position: await _controller.getCameraPosition()));
                },
                onMapReady: (controller) async {
                  _controller = controller;

                  for (NMarker marker in state.markers) {
                    marker.setIsHideCollidedCaptions(true);
                    marker.setIsHideCollidedMarkers(true);

                    marker.setOnTapListener(
                      (overlay) {
                        BlocProvider.of<BoothBloc>(context).add(
                          FetchBoothData(state
                              .itemsLatLng[marker.info.id]!['location_id']),
                        );

                        context.router.push(HomeEventRoute(
                          placeID:
                              state.itemsLatLng[marker.info.id]!['place_id'],
                          position: marker.position,
                          locID:
                              state.itemsLatLng[marker.info.id]!['location_id'],
                          name: state.itemsLatLng[marker.info.id]!['name'],
                        ));
                      },
                    );

                    marker.setSize(const Size(33, 51));

                    controller.addOverlay(marker);
                  }
                },
                options: getNaverMapOptions(state),
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
      ),
    );
  }

  NaverMapViewOptions getNaverMapOptions(PlaceLoaded state) {
    return NaverMapViewOptions(
      locationButtonEnable: true,
      initialCameraPosition: NCameraPosition(
        target: (position != null && state.position?.target != null)
            ? position!
            : (position == null && state.position?.target != null)
                ? state.position!.target
                : (position != null && state.position?.target == null)
                    ? position!
                    : (position == null && state.position?.target == null)
                        ? const NLatLng(
                            37.54388829908806,
                            127.07595459999982,
                          )
                        : state.position!.target,
        zoom: state.position?.zoom ?? 13.5,
      ),
      extent: const NLatLngBounds(
        southWest: NLatLng(31.43, 122.37),
        northEast: NLatLng(44.35, 132.0),
      ),
    );
  }
}
