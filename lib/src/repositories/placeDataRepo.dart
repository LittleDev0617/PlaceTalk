import 'package:flutter_naver_map/flutter_naver_map.dart';

import '../models/placesModel.dart';

// class placeDataRepo {
//   Future<Map<String, dynamic>> fetchData() async {
//     await Future.delayed(const Duration(seconds: 1));

//     final List<Map<String, dynamic>> apiData = [
//       {
//         'id': 1,
//         'name': '건국대',
//         'latitude': 37.5407,
//         'longitude': 127.0793,
//         'joining': 1234,
//         'start_date': '2023-08-01T00:00:00Z',
//         'end_date': '2023-08-05T00:00:00Z',
//       },
//       {
//         'id': 2,
//         'name': '세종대',
//         'latitude': 37.5512,
//         'longitude': 127.0731,
//         'joining': 5678,
//         'start_date': '2023-08-03T00:00:00Z',
//         'end_date': '2023-08-07T00:00:00Z',
//       },
//     ];

//     // Extract names from API data
//     Map<String, Map<String, double>> createCoordinatesMap(
//         List<Map<String, dynamic>> apiData) {
//       Map<String, Map<String, double>> coordinatesMap = {};

//       for (final data in apiData) {
//         final name = data['name'] as String;
//         final latitude = data['latitude'] as double;
//         final longitude = data['longitude'] as double;

//         coordinatesMap[name] = {'latitude': latitude, 'longitude': longitude};
//       }

//       return coordinatesMap;
//     }

//     // Convert API data to placeModel instances
//     List<placeModel> dataList =
//         apiData.map((jsonData) => placeModel.fromJson(jsonData)).toList();

//     Set<NMarker> markers = dataList.map((data) => data.toNMarker()).toSet();

//     return {'names': names, 'markers': markers};
//   }
// }

class placeDataRepo {
  Future<Map<String, dynamic>> fetchData() async {
    await Future.delayed(const Duration(seconds: 1));

    final List<Map<String, dynamic>> apiData = [
      {
        'id': 'KUxSJU',
        'name': '건국대 x 세종대 축제',
        'latitude': 37.54388827708887,
        'longitude': 127.07596063613892,
        'joining': 1234,
        'start_date': '2023-08-07',
        'end_date': '2023-08-07',
      },
      {
        'id': 'YUxKU',
        'name': '연세대 x 고려대 축제',
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
        final name = data['name'] as String;
        final latitude = data['latitude'] as double;
        final longitude = data['longitude'] as double;
        final startDate = data['start_date'] as String;
        final endDate = data['end_date'] as String;

        itemsLatLng[name] = {
          'latitude': latitude,
          'longitude': longitude,
          'start_date': startDate,
          'end_date': endDate,
        };
      }

      return itemsLatLng;
    }

    List<placeModel> dataList =
        apiData.map((jsonData) => placeModel.fromJson(jsonData)).toList();

    Set<NMarker> markers = dataList.map((data) => data.toNMarker()).toSet();

    List<String> namesList =
        apiData.map((data) => data['name'] as String).toList();

    return {
      'markers': markers,
      'itemsLatLng': createCoordinatesMap(apiData),
      'names': namesList,
    };
  }
}
