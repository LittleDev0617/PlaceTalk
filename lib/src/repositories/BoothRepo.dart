import 'package:flutter_naver_map/flutter_naver_map.dart';

import '../models/BoothModel.dart';
import 'SessionRepo.dart';

class BoothRepo {
  final SessionRepo _sessionRepo;

  BoothRepo(this._sessionRepo);

  Future<Map<String, dynamic>> fetchData(int placeID) async {
    await Future.delayed(const Duration(seconds: 1));
    final apiData = await _sessionRepo.get('api/places/$placeID/booth');

    List<BoothModel> dataList =
        (apiData).map((jsonData) => BoothModel.fromJson(jsonData)).toList();

    // Create a list of NMarker objects from the dataList
    Set<NMarker> markers = dataList.map((booth) => booth.toNMarker()).toSet();

    // Create a map of booth data with combined name and locName
    Map<String, dynamic> itemsLatLng = createBoothDataMap(dataList);

    return {
      'markers': markers,
      'itemsLatLng': itemsLatLng,
    };
  }

  Map<String, dynamic> createBoothDataMap(List<BoothModel> dataList) {
    Map<String, dynamic> boothDataMap = {};

    for (final data in dataList) {
      final name = data.name;
      final locName =
          data.locations.isNotEmpty ? data.locations[0].locName : '';
      final latitude = data.locations.isNotEmpty ? data.locations[0].lat : 0.0;
      final longitude = data.locations.isNotEmpty ? data.locations[0].lon : 0.0;
      final boothId = data.boothId;
      final onTime = data.onTime;
      final content = data.content;

      final images = data.images.map((image) => image.toJson()).toList();

      // Combine booth name and locName if locName is available

      boothDataMap[boothId.toString()] = {
        'name': name,
        'loc_name': locName,
        'latitude': latitude,
        'longitude': longitude,
        'booth_id': boothId,
        'on_time': onTime,
        'content': content,
        'images': images,
      };
    }

    return boothDataMap;
  }
}
