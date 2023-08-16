import '../models/PlaceInfoModel.dart';
import 'SessionRepo.dart';

class PlaceInfoRepo {
  final SessionRepo _sessionRepo;

  PlaceInfoRepo(this._sessionRepo);

  Future<List<PlaceInfoModel>> fetchPlaceInfoData(int placeID) async {
    final apiData = await _sessionRepo.get('api/infos?place_id=$placeID');

    List<PlaceInfoModel> placeInfoList = List<PlaceInfoModel>.from(
        apiData.map((jsonData) => PlaceInfoModel.fromJson(jsonData)));

    return placeInfoList;
  }

  Future<Map<String, dynamic>> fetchPlaceTimeData(int placeID) async {
    final apiData = await _sessionRepo.get('api/places/$placeID/schedule');
    Map<String, dynamic> items = {};

    final data = apiData[0];

    items = {
      'images': data,
    };

    return items;
  }
}
