import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:placetalk/src/blocs/BoothBlocs/booth_bloc.dart';

import '../routes/routes.gr.dart';

@RoutePage()
class HomeEventScreen extends StatefulWidget {
  final int placeID;
  final String name;
  final NLatLng position;

  const HomeEventScreen({
    super.key,
    required this.name,
    required this.position,
    @PathParam('placeID') required this.placeID,
  });

  @override
  State<HomeEventScreen> createState() => _HomeEventScreenState();
}

class _HomeEventScreenState extends State<HomeEventScreen> {
  var _showBottomSheet = true;
  final DraggableScrollableController _scrollController =
      DraggableScrollableController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: const AutoLeadingButton(),
        title: Text(
          widget.name,
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
            return const Center(child: CircularProgressIndicator());
          } else if (state is BoothLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BoothLoaded) {
            if (state.itemsLatLng.isEmpty) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                AutoRouter.of(context).parent<TabsRouter>()!.navigate(
                      EventsRouter(
                        children: [
                          EventLandingRoute(
                            placeID: widget.placeID,
                            name: widget.name,
                            children: [
                              InformEventRoute(
                                placeID: widget.placeID,
                                name: widget.name,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
              });
            }
            return Stack(
              children: [
                NaverMap(
                  onMapReady: (controller) {
                    NMarker eventMarker = NMarker(
                        captionAligns: [NAlign.top],
                        id: widget.position.hashCode.toString(),
                        position: widget.position);

                    eventMarker.setCaption(
                      const NOverlayCaption(
                        text: '행사정보',
                        textSize: 14,
                        color: Colors.black,
                      ),
                    );

                    eventMarker.setSubCaption(
                      const NOverlayCaption(
                        text: '자세히 보기',
                        textSize: 14,
                        color: Colors.black,
                      ),
                    );

                    eventMarker.setOnTapListener((overlay) {
                      AutoRouter.of(context).parent<TabsRouter>()!.navigate(
                            EventsRouter(
                              children: [
                                EventLandingRoute(
                                  placeID: widget.placeID,
                                  name: widget.name,
                                  children: [
                                    InformEventRoute(),
                                  ],
                                ),
                              ],
                            ),
                          );
                    });

                    controller.addOverlay(eventMarker);

                    for (NMarker marker in state.markers) {
                      marker.setSize(const Size(32, 32));

                      marker.setOnTapListener((overlay) {
                        controller.clearOverlays();
                        controller.addOverlay(marker);

                        showBottomSheet(
                          context: context,
                          builder: ((BuildContext context) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              setState(() {
                                _showBottomSheet = false;
                              });
                            });
                            return BoothBottomSheet(
                              context,
                              state.itemsLatLng[marker.info.id.toString()]
                                  ['name'],
                              state.itemsLatLng[marker.info.id.toString()]
                                  ['loc_name'],
                              state.itemsLatLng[marker.info.id.toString()]
                                  ['on_time'],
                              state.itemsLatLng[marker.info.id.toString()]
                                  ['content'],
                              state
                                  .itemsLatLng[marker.info.id.toString()]
                                      ['images']
                                  .length,
                              state.itemsLatLng[marker.info.id.toString()]
                                  ['images'],
                            );
                          }),
                        ).closed.then((value) {
                          controller.addOverlay(eventMarker);
                          controller.addOverlayAll(state.markers);
                          setState(() {
                            _showBottomSheet = true;
                          });
                        });
                      });
                    }
                    controller.addOverlayAll(state.markers);
                  },
                  options: NaverMapViewOptions(
                    initialCameraPosition:
                        NCameraPosition(target: widget.position, zoom: 14.5),
                    locationButtonEnable: true,
                  ),
                ),
                if (_showBottomSheet)
                  DraggableScrollableSheet(
                    initialChildSize: 0.3, // Initial size of the sheet
                    minChildSize: 0.2, // Minimum size the sheet can shrink to
                    maxChildSize: 0.85, // Maximum size the sheet can expand to
                    controller: _scrollController,
                    builder: (context, controller) {
                      return Container(
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
                        child: Column(
                          children: [
                            Container(
                              height: 80,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: .1,
                                    color:
                                        const Color(0xff707070).withOpacity(.2),
                                  ),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: 4,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffFF7D7D),
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: ListView.separated(
                                controller:
                                    controller, // Important: Use the controller here
                                itemCount: state.itemsLatLng
                                    .length, // Replace with your item count
                                itemBuilder: (context, index) {
                                  var itemIndex = state.itemsLatLng.keys
                                      .toList()[index]
                                      .toString();
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 16,
                                    ),
                                    child: ListTile(
                                      onTap: () {
                                        print(state.itemsLatLng[itemIndex]
                                            ['images']);

                                        setState(() {
                                          _showBottomSheet = false;
                                        });
                                        showBottomSheet(
                                          context: context,
                                          builder: ((BuildContext context) {
                                            return BoothBottomSheet(
                                              context,
                                              state.itemsLatLng[itemIndex]
                                                  ['name'],
                                              state.itemsLatLng[itemIndex]
                                                  ['loc_name'],
                                              state.itemsLatLng[itemIndex]
                                                  ['on_time'],
                                              state.itemsLatLng[itemIndex]
                                                  ['content'],
                                              state
                                                  .itemsLatLng[itemIndex]
                                                      ['images']
                                                  .length,
                                              state.itemsLatLng[itemIndex]
                                                  ['images'],
                                            );
                                          }),
                                        ).closed.then((value) {
                                          setState(() {
                                            _showBottomSheet = true;
                                          });
                                        });
                                      },
                                      title: Text(
                                        '${state.itemsLatLng[itemIndex]['name']}',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black,
                                        ),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${state.itemsLatLng[itemIndex]['loc_name']}',
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                              color:
                                                  Colors.black.withOpacity(.45),
                                            ),
                                          ),
                                          Text(
                                            '${state.itemsLatLng[itemIndex]['on_time']}',
                                            style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      trailing: Container(
                                        width: 95,
                                        height: 65,
                                        margin: const EdgeInsets.only(right: 5),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                'http://125.180.98.19:1234/images/${state.itemsLatLng[itemIndex]['images'][0]['image_id']}'),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) => Divider(
                                  thickness: .1,
                                  color:
                                      const Color(0xff707070).withOpacity(.2),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
              ],
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
                      placeID: widget.placeID,
                      name: widget.name,
                      children: [
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

  Container BoothBottomSheet(
    BuildContext context,
    String boothName,
    String boothLocName,
    String boothOnTime,
    String boothContent,
    int imageCount,
    List<Map<String, dynamic>> images,
  ) {
    return Container(
      height: MediaQuery.of(context).size.height * .3,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15), // Shadow color
            offset: const Offset(0, -1), // y direction, -1 means upwards
            blurRadius: 4, // Blur radius
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  boothName,
                  style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                const SizedBox(width: 12.5),
                Text(
                  boothLocName,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withOpacity(.47),
                  ),
                ),
                const Spacer(),
                Text(
                  boothOnTime,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              boothContent,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black.withOpacity(.47)),
            ),
            const SizedBox(height: 25),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: imageCount,
                itemBuilder: (context, index) {
                  return Container(
                    height: imageCount == 1 ? 150 : 75,
                    width: imageCount == 1 ? 200 : 100,
                    margin: const EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                'http://125.180.98.19:1234/images/${images[index]['image_id']}')),
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white38),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
