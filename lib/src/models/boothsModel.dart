import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:flutter_naver_map/flutter_naver_map.dart';

class boothModel extends Equatable {
  final int id;
  final NLatLng position;
  final String? title;
  final String? content;

  boothModel({
    required this.id,
    required this.position,
    this.title,
    this.content,
  });

  @override
  List<Object?> get props => [id, title, content, position];

  static boothModel fromJson(Map<String, dynamic> json) {
    return boothModel(
      id: json['id'],
      title: json['text'],
      content: json['content'],
      position: NLatLng(
        json['latitude'] as double,
        json['longitude'] as double,
      ),
    );
  }

  NMarker toNMarker() {
    return NMarker(
      id: id.toString(),
      position: position,
    );
  }
}
