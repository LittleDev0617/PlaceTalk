import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:placetalk/src/blocs/BoothBlocs/booth_bloc.dart';

import '../routes/routes.gr.dart';

@RoutePage()
class HomeEventScreen extends StatelessWidget {
  final int eventID;
  final String name;

  const HomeEventScreen({
    super.key,
    required this.name,
    required this.position,
    @PathParam('eventID') required this.eventID,
  });
  final NLatLng position;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: const AutoLeadingButton(),
        title: Text(
          name,
          style: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            color: const Color(0xffff7d7d),
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          const SizedBox(width: 24),
        ],
      ),
      body: BlocBuilder<BoothBloc, BoothState>(
        builder: (context, state) {
          if (state is BoothInitial) {
            BlocProvider.of<BoothBloc>(context).add(FetchBoothData(eventID));
            return const SizedBox.shrink();
          } else if (state is BoothLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BoothLoaded) {
            return NaverMap(
              onMapReady: (controller) {
                for (NMarker marker in state.markers) {
                  marker.setSize(const Size(32, 32));

                  marker.setOnTapListener((overlay) {
                    controller.clearOverlays();
                    controller.addOverlay(marker);

                    showBottomSheet(
                      context: context,
                      builder: ((BuildContext context) {
                        return Container(
                          height: MediaQuery.of(context).size.height * .25,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black
                                    .withOpacity(0.15), // Shadow color
                                offset: const Offset(
                                    0, -1), // y direction, -1 means upwards
                                blurRadius: 4, // Blur radius
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text('경영대 주막'),
                                    Text('황소상 앞'),
                                    Spacer(),
                                    Text('10:00~18:00'),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                    ).closed.then(
                        (value) => controller.addOverlayAll(state.markers));
                  });
                }
                controller.addOverlayAll(state.markers);
              },
              options: NaverMapViewOptions(
                initialCameraPosition:
                    NCameraPosition(target: position, zoom: 14.5),
                locationButtonEnable: true,
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        shape: const CircleBorder(),
        onPressed: () {
          AutoRouter.of(context).parent<TabsRouter>()!.navigate(
                EventsRouter(
                  children: [
                    EventLandingRoute(
                      eventID: eventID,
                      name: name,
                      children: const [
                        TimeEventRoute(),
                      ],
                    ),
                  ],
                ),
              );
        },
        child: const Icon(
          Icons.alarm,
          color: Color(0xffADADAD),
        ),
      ),
    );
  }
}
