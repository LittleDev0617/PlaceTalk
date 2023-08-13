import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:intl/intl.dart';

class PlaceModel extends Equatable {
  final int placeId;
  final String name;
  final String category;
  final int state;
  final DateTime? startDate;
  final DateTime? endDate;
  final List<Location>? locations;

  const PlaceModel({
    required this.placeId,
    required this.name,
    required this.category,
    required this.state,
    this.startDate,
    this.endDate,
    this.locations,
  });

  @override
  List<Object?> get props => [
        placeId,
        name,
        category,
        state,
        startDate,
        endDate,
        locations,
      ];

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> jsonLocations = json['locations'];
    final List<Map<String, dynamic>> locationList =
        List<Map<String, dynamic>>.from(jsonLocations);
    final List<Location> locations = locationList.map((locationJson) {
      return Location.fromJson(locationJson);
    }).toList();

    return PlaceModel(
      placeId: json['place_id'],
      name: json['name'],
      category: json['category'],
      state: json['state'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      locations: locations,
    );
  }

  List<NMarker> toNMarkers() {
    List<NMarker> markers = [];

    for (int i = 0; i < locations!.length; i++) {
      final locName = locations![i].locName;

      markers.add(NMarker(
          id: locName.isEmpty ? name : '$name ($locName)',
          position: NLatLng(
            locations![i].lat,
            locations![i].lon,
          ),
          caption: NOverlayCaption(text: '$name $locName', textSize: 16),
          subCaption: NOverlayCaption(
            text: state == 0
                ? '상시'
                : '${DateFormat('M.d').format(startDate!)}~${DateFormat('M.d').format(endDate!)}',
            color: Colors.grey,
            textSize: 18,
          ),
          captionAligns: [NAlign.top],
          icon: NOverlayImage.fromAssetImage(
            state == 0
                ? 'assets/images/always_marker.png'
                : 'assets/images/moment_marker.png',
          )));
    }

    return markers;
  }
}

class Location {
  final int locationId;
  final String locName;
  final double lat;
  final double lon;

  Location({
    required this.locationId,
    required this.locName,
    required this.lat,
    required this.lon,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      locationId: json['location_id'] as int,
      locName: json['loc_name'] as String,
      lat: json['lat'] as double,
      lon: json['lon'] as double,
    );
  }
}
