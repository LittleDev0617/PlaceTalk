import 'package:flutter_naver_map/flutter_naver_map.dart';

import '../models/boothsModel.dart';

class boothDataRepo {
  Future<Map<String, dynamic>> fetchData() async {
    await Future.delayed(const Duration(seconds: 1));

    final List<Map<String, dynamic>> apiData = [
      {
        'id': 1,
        'latitude': 37.5421,
        'longitude': 127.0739,
        'title': 'Booth A',
        'addr': '상허기념도서관',
        'content': 'This is booth A',
      },
      {
        'id': 2,
        'latitude': 37.5423,
        'longitude': 127.0760,
        'title': 'Booth B',
        'addr': '상허기념박물관 앞',
        'content': 'This is booth B',
      },
      {
        'id': 3,
        'latitude': 37.5415,
        'longitude': 127.0779,
        'title': 'Booth C',
        'addr': '노천극장',
        'content': 'This is booth C',
      },
    ];

    List<boothModel> dataList =
        apiData.map((jsonData) => boothModel.fromJson(jsonData)).toList();

    Set<NMarker> markers = dataList.map((data) => data.toNMarker()).toSet();
    return {
      'markers': markers,
      'dataList': dataList,
    };
  }
}
