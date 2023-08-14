import '../models/FeedModel.dart';
import 'SessionRepo.dart';

class FeedRepo {
  final SessionRepo _sessionRepo;

  FeedRepo(this._sessionRepo);

  Future<List<FeedModel>> fetchFeedData() async {
    await Future.delayed(const Duration(seconds: 1));
    final apiData = await _sessionRepo.get('api/places/feed');

    List<FeedModel> feedList = List<FeedModel>.from(
        apiData.map((jsonData) => FeedModel.fromJson(jsonData)));

    return feedList;
  }

  Future<List<FeedModel>> fetchEventFeedData(int placeID) async {
    await Future.delayed(const Duration(seconds: 1));

    final apiData = await _sessionRepo.get('api/places/$placeID/feed');

    List<FeedModel> feedList = List<FeedModel>.from(
        apiData.map((jsonData) => FeedModel.fromJson(jsonData)));

    return feedList;
  }
}
