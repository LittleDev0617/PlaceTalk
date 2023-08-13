import 'package:equatable/equatable.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class BoothModel extends Equatable {
  final int boothId;
  final String name;
  final String content;
  final String onTime;
  final List<Location> locations;
  final List<CustomImage> images;

  const BoothModel({
    required this.boothId,
    required this.name,
    required this.content,
    required this.onTime,
    required this.locations,
    required this.images,
  });

  @override
  List<Object?> get props =>
      [boothId, name, content, onTime, locations, images];

  factory BoothModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> jsonLocations = json['locations'];
    final List<Location> locations = jsonLocations
        .map((locationJson) => Location.fromJson(locationJson))
        .toList();

    final List<dynamic> jsonImages = json['images'];
    final List<CustomImage> images =
        jsonImages.map((imageJson) => CustomImage.fromJson(imageJson)).toList();

    return BoothModel(
      boothId: json['booth_id'],
      name: json['name'],
      content: json['content'],
      onTime: json['on_time'],
      locations: locations,
      images: images,
    );
  }

  NMarker toNMarker() {
    return NMarker(
      id: boothId.toString(),
      position: NLatLng(
        locations[0].lat,
        locations[0].lon,
      ),
      icon: const NOverlayImage.fromAssetImage(
        'assets/images/booth_marker.png',
      ),
    );
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
      locationId: json['location_id'],
      locName: json['loc_name'],
      lat: json['lat'],
      lon: json['lon'],
    );
  }
}

class CustomImage {
  final String imageId;
  final int order;

  CustomImage({
    required this.imageId,
    required this.order,
  });

  factory CustomImage.fromJson(Map<String, dynamic> json) {
    return CustomImage(
      imageId: json['image_id'],
      order: json['order'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image_id': imageId,
      'order': order,
    };
  }
}
