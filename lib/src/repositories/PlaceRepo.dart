import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:placetalk/src/repositories/SessionRepo.dart';

import '../models/LocationPermissionStatusModel.dart';
import '../models/PlaceModel.dart';

class PlaceRepo {
  final SessionRepo _sessionRepo;

  PlaceRepo(this._sessionRepo);

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

    final apiData = await _sessionRepo.get('api/places');

    List<PlaceModel> dataList =
        apiData.map((jsonData) => PlaceModel.fromJson(jsonData)).toList();

    Set<NMarker> markers = {};
    for (int i = 0; i < dataList.length; i++) {
      markers.addAll(dataList[i].toNMarkers());
    }

    return {
      'markers': markers,
      'itemsLatLng': createCoordinatesMap(apiData),
    };
  }

  Future<Map<String, dynamic>> fetchNearData() async {
    Position? position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium);

    double lon = position.longitude;
    double lat = position.latitude;

    await Future.delayed(const Duration(seconds: 1));

    final apiData =
        await _sessionRepo.get('api/places?lat=$lat&lon=$lon&dist=3');

    return {
      'itemsLatLng': createCoordinatesMap(apiData),
    };
  }

  Future<Map<String, dynamic>> fetchCategoryData(String category) async {
    await Future.delayed(const Duration(seconds: 1));

    final apiData = await _sessionRepo.get('api/places?category=$category');

    List<PlaceModel> dataList =
        apiData.map((jsonData) => PlaceModel.fromJson(jsonData)).toList();

    Set<NMarker> markers = {};
    for (int i = 0; i < dataList.length; i++) {
      markers.addAll(dataList[i].toNMarkers());
    }

    return {
      'markers': markers,
      'itemsLatLng': createCoordinatesMap(apiData),
    };
  }

  Future<Map<String, dynamic>> fetchJoinData() async {
    await Future.delayed(const Duration(seconds: 1));

    final apiData = await _sessionRepo.get(
      'api/users/place',
    );

    return {
      'itemsLatLng': createCoordinatesMap(apiData),
    };
  }

  Map<String, Map<String, dynamic>> createCoordinatesMap(
      List<Map<String, dynamic>> apiData) {
    Map<String, Map<String, dynamic>> itemsLatLng = {};

    for (final data in apiData) {
      final locations = data['locations'];
      final name = data['name'];

      for (final location in locations) {
        final locName = location['loc_name'];
        final latitude = location['lat'];
        final longitude = location['lon'];
        final state = data['state'];
        final startDate = DateTime.parse(data['start_date']);
        final endDate = DateTime.parse(data['end_date']);

        itemsLatLng[locName == '' ? name : '$name ($locName)'] = {
          'name': name,
          'loc_name': locName,
          'latitude': latitude,
          'longitude': longitude,
          'state': state,
          'startDate': startDate,
          'endDate': endDate,
        };
      }
    }

    return itemsLatLng;
  }
}
