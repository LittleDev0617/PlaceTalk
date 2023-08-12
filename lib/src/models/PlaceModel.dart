import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class PlaceModel extends Equatable {
  final String id;
  final NLatLng position;
  final int? joining;
  final String? name;
  final DateTime? startDate;
  final DateTime? endDate;

  const PlaceModel({
    required this.id,
    required this.position,
    this.name,
    this.joining,
    this.startDate,
    this.endDate,
  });

  @override
  List<Object?> get props => [
        id,
        position,
        name,
        joining,
        startDate,
        endDate,
      ];

  static PlaceModel fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      id: NLatLng(
        json['latitude'] as double,
        json['longitude'] as double,
      ).hashCode.toString(),
      position: NLatLng(
        json['latitude'] as double,
        json['longitude'] as double,
      ),
      name: json['name'],
      joining: json['joining'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
    );
  }

  NMarker toNMarker() {
    return NMarker(
      id: id,
      position: position,
      caption: NOverlayCaption(text: name ?? 'error', textSize: 18),
      subCaption: NOverlayCaption(
          text: '${joining ?? 0}명 참여 중', color: Colors.grey, textSize: 14),
      captionAligns: [NAlign.top],
    );
  }
}
