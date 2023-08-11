import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class placeModel extends Equatable {
  final String id;
  final int? joining;
  final String? name;
  final NLatLng position;
  final String? start_date;
  final String? end_date;

  const placeModel({
    required this.id,
    required this.position,
    this.name,
    this.joining,
    this.start_date,
    this.end_date,
  });

  @override
  List<Object?> get props => [
        id,
        position,
        name,
        joining,
        start_date,
        end_date,
      ];

  get context => null;

  static placeModel fromJson(Map<String, dynamic> json) {
    return placeModel(
      id: json['id'],
      position: NLatLng(
        json['latitude'] as double,
        json['longitude'] as double,
      ),
      name: json['name'],
      joining: json['joining'],
      start_date: json['start_date'],
      end_date: json['end_date'],
    );
  }

  NMarker toNMarker() {
    return NMarker(
      id: id,
      position: position,
      caption: NOverlayCaption(text: name ?? 'error', textSize: 18),
      subCaption: NOverlayCaption(
        text: '${joining ?? 0}명 참여 중',
        color: Colors.grey,
        textSize: 14,
      ),
      captionAligns: [NAlign.top],
    );
  }
}
