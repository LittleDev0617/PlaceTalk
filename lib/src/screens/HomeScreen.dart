import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:placex/src/blocs/boothBlocs/booth_bloc.dart';
import 'package:placex/src/blocs/dropdownBlocs/dropdown_bloc.dart';

import 'package:placex/src/components/buttons.dart';
import 'package:placex/src/components/modal.dart';
import '../blocs/placeBlocs/place_bloc.dart';
import '../components/naverMapOptions.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BoothBloc, BoothBlocState>(
      builder: (context, state) {
        if (state is BoothLoaded) {
          return HomePageEvent(position: state.position);
        } else {
          return HomePageWorld(position: state.position);
        }
      },
    );
  }
}

class HomePageWorld extends StatelessWidget {
  HomePageWorld({
    this.position,
    super.key,
  });

  NLatLng? position;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(9),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BlocBuilder<DropdownBloc, DropdownBlocState>(
                builder: (context, state) {
                  if (state is DropdownInitial) {
                    return const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else if (state is DropdownWithData) {
                    return Expanded(
                      child: DropdownMapButton(
                        itemList: state.itemsLatLng,
                        controller: state.controller,
                      ),
                    );
                  } else {
                    return DropdownMapButtonNull(
                      itemList: const {
                        '등록된 데이터가 없습니다.': {'latitude': 0.0, 'longitude': 0.0}
                      },
                    );
                  }
                },
              ),
              const CircleAvatarIconButton(
                iconSize: 24,
                backgroundColor: Colors.white,
                iconColor: Color(0xffFF7D7D),
                icon: Icons.notifications_outlined,
                onPressed: null,
              ),
            ],
          ),
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     SizedBox(width: 20.w),
        //     BlocBuilder<DropdownBloc, DropdownBlocState>(
        //       builder: (context, state) {
        //         if (state is DropdownInitial) {
        //           return const CircularProgressIndicator();
        //         } else if (state is DropdownWithData) {
        //           return Container(
        //             padding: const EdgeInsets.symmetric(horizontal: 5),
        //             decoration: BoxDecoration(
        //               color: Colors.white,
        //               borderRadius: BorderRadius.circular(12),
        //             ),
        //             width: MediaQuery.of(context).size.width / 1.7,
        //             child: DropdownMapButton(
        //               itemList: state.itemsLatLng,
        //               controller: state.controller,
        //             ),
        //           );
        //         } else {
        //           return DropdownMapButtonNull(
        //             itemList: const {
        //               '등록된 데이터가 없습니다.': {'latitude': 0.0, 'longitude': 0.0}
        //             },
        //           );
        //         }
        //       },
        //     ),
        //     const CircleAvatarIconButton(
        //       backgroundColor: Colors.black87,
        //       iconColor: Colors.white,
        //       icon: Icons.notifications_rounded,
        //       onPressed: null,
        //     ),
        //   ],
        // ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: BlocBuilder<PlaceBloc, PlaceBlocState>(
        builder: (context, state) {
          if (state is NaverMapInitial) {
            BlocProvider.of<PlaceBloc>(context).add(
              FetchNaverMapDataEvent(),
            );
            return const Center(child: CircularProgressIndicator());
          } else if (state is NaverMapLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NaverMapLoaded) {
            Set<NMarker> markers = state.markers;

            return NaverMap(
              onMapReady: (NaverMapController controller) {
                controller.addOverlayAll(markers);

                BlocProvider.of<DropdownBloc>(context).add(
                  FetchDataEvent(controller),
                );

                for (NMarker marker in markers) {
                  marker.setOnTapListener(
                    (overlay) {
                      BlocProvider.of<BoothBloc>(context).add(
                        FetchBoothDataEvent(marker.position, marker),
                      );
                    },
                  );
                }
              },
              onSymbolTapped: (symbolInfo) {},
              onMapTapped: (point, latLng) {},
              options: naverMapOptionsWorld(position: position).option,
            );
          } else {
            return const Center(child: Text('Error'));
          }
        },
      ),
    );
  }
}

class HomePageEvent extends StatelessWidget {
  const HomePageEvent({Key? key, required this.position});

  final NLatLng position;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatarIconButton(
              iconSize: 24,
              backgroundColor: Colors.transparent,
              iconColor: Colors.black87,
              icon: Icons.arrow_back_ios,
              onPressed: () {
                BlocProvider.of<BoothBloc>(context).add(
                  PopBoothDataEvent(position),
                );
              },
            ),
            CircleAvatarIconButton(
              iconSize: 24,
              backgroundColor: Colors.white,
              iconColor: const Color(0xffFF7D7D),
              icon: Icons.notifications_outlined,
              onPressed: () {},
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: BlocBuilder<BoothBloc, BoothBlocState>(
        builder: (context, state) {
          if (state is BoothInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BoothLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BoothLoaded) {
            Set<NMarker> markers = state.markers;

            return Stack(
              children: [
                NaverMap(
                  onMapReady: (NaverMapController controller) {
                    controller.addOverlayAll(markers);
                    controller.addOverlay(state.mainMaker);

                    for (NMarker marker in markers) {
                      marker.setOnTapListener(
                        (overlay) => {
                          showBottomSheet(
                            context: context,
                            builder: (context) {
                              return BoothItemModal();
                            },
                          )
                        },
                      );
                    }
                  },
                  forceGesture: false,
                  onMapTapped: (point, latLng) {}, // 관리자일때
                  options: naverMapOptionsEvent(position: position).option,
                ),
                BoothListModal(),
              ],
            );
          } else {
            return const Center(child: Text('Error'));
          }
        },
      ),
    );
  }
}
