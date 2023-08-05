import 'package:flutter_naver_map/flutter_naver_map.dart';

class naverMapOptionsWorld {
  final NLatLng? position;

  naverMapOptionsWorld({
    this.position,
  });

  NaverMapViewOptions get option {
    return NaverMapViewOptions(
      initialCameraPosition: NCameraPosition(
          target: position ?? const NLatLng(37.5418, 127.0771),
          zoom: 14.5,
          bearing: 0,
          tilt: 0),
      scaleBarEnable: false,
      logoClickEnable: false,
      extent: const NLatLngBounds(
        southWest: NLatLng(31.43, 122.37),
        northEast: NLatLng(44.35, 132.0),
      ),
    );
  }
}

class naverMapOptionsEvent {
  final NLatLng position;

  naverMapOptionsEvent({
    required this.position,
  });

  NaverMapViewOptions get option => NaverMapViewOptions(
        initialCameraPosition:
            NCameraPosition(target: position, zoom: 14.5, bearing: 0, tilt: 0),
        scaleBarEnable: false,
        scrollGesturesEnable: true,
        logoClickEnable: false,
        extent: const NLatLngBounds(
          southWest: NLatLng(31.43, 122.37),
          northEast: NLatLng(44.35, 132.0),
        ),
      );
}
