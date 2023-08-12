import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';

import '../models/LocationPermissionStatusModel.dart';
import '../models/PlaceModel.dart';

class PlaceRepo {
  Future<LocationPermissionStatusModel> checkLocationPermission() async {
    return await Geolocator.requestPermission().then((permission) {
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return LocationPermissionStatusModel.denied;
      } else if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        return LocationPermissionStatusModel.granted;
      } else {
        return LocationPermissionStatusModel.unknown;
      }
    });
  }

  Future<Map<String, dynamic>> fetchData() async {
    await Future.delayed(const Duration(seconds: 1));

    final List<Map<String, dynamic>> apiData = [
      //    "place_id"      : int,
      // "name"          : string,
      // "category"      : string,
      // "state"         : int,    // 0 : 핫플 / 1 : 행사
      // "start_date"    : datetime,
      // "end_date"      : datetime,
      // "locations"     : List<Location>
      {
        'id': 1,
        'name': '건국대 x 세종대 축제 [건국대]',
        'latitude': 37.54388827708887,
        'longitude': 127.07596063613892,
        'joining': 1234,
        'start_date': '2023-08-07',
        'end_date': '2023-08-07',
      },
      {
        'id': 'YUxKU',
        'name': '건국대 x 세종대 축제',
        'latitude': 37.567116598039874,
        'longitude': 126.93903923034668,
        'joining': 4321,
        'start_date': '2023-08-07',
        'end_date': '2023-08-07',
      },
      {
        'id': 'Gangnam',
        'name': '강남역',
        'latitude': 37.497954687223526,
        'longitude': 127.02761650085449,
        'joining': 1324,
        'start_date': '2023-08-03',
        'end_date': '2023-08-07',
      },
      {
        'id': 'Lotteworld',
        'name': '롯데월드',
        'latitude': 37.511079023882786,
        'longitude': 127.09816932678223,
        'joining': 1324,
        'start_date': '2023-08-03',
        'end_date': '2023-08-07',
      },
      {
        'id': 'Banporiverpark',
        'name': '반포한강공원',
        'latitude': 37.51000669383035,
        'longitude': 126.99502229690552,
        'joining': 1324,
        'start_date': '2023-08-03',
        'end_date': '2023-08-07',
      },
    ];

    Map<String, Map<String, dynamic>> createCoordinatesMap(
        List<Map<String, dynamic>> apiData) {
      Map<String, Map<String, dynamic>> itemsLatLng = {};

      for (final data in apiData) {
        final name = data['name'];
        final latitude = data['latitude'];
        final longitude = data['longitude'];
        final startDate = DateTime.parse(data['start_date']);
        final endDate = DateTime.parse(data['end_date']);

        itemsLatLng[name] = {
          'name': name,
          'latitude': latitude,
          'longitude': longitude,
          'startDate': startDate,
          'endDate': endDate,
        };
      }

      return itemsLatLng;
    }

    List<PlaceModel> dataList =
        apiData.map((jsonData) => PlaceModel.fromJson(jsonData)).toList();

    Set<NMarker> markers = dataList.map((data) => data.toNMarker()).toSet();

    return {
      'markers': markers,
      'itemsLatLng': createCoordinatesMap(apiData),
    };
  }
}
