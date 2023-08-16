import '../models/FeedModel.dart';
import 'SessionRepo.dart';

class FeedRepo {
  final SessionRepo _sessionRepo;

  FeedRepo(this._sessionRepo);

  Future<List<FeedModel>> fetchFeedData() async {
    await Future.delayed(const Duration(seconds: 1));
    final apiData = await _sessionRepo.get('api/feeds');

    List<FeedModel> feedList = List<FeedModel>.from(
        apiData.map((jsonData) => FeedModel.fromJson(jsonData)));

    return feedList;
  }

  Future<List<FeedModel>> fetchEventFeedData(int placeID) async {
    await Future.delayed(const Duration(seconds: 1));

    final apiData = await _sessionRepo.get('api/feeds?place_id=$placeID');

    List<FeedModel> feedList = List<FeedModel>.from(
        apiData.map((jsonData) => FeedModel.fromJson(jsonData)));

    return feedList;
  }
}
