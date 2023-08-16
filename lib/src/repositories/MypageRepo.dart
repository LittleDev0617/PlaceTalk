import '../models/MyPageModel.dart';
import 'SessionRepo.dart';

class MypageRepo {
  final SessionRepo _sessionRepo;

  MypageRepo(this._sessionRepo);

  Future<MyPageModel> fetchMypageData(int userId) async {
    final apiData = await _sessionRepo.get('api/users/mypage?user_id=$userId');

    return _mapJsonToMypageModel(apiData);
  }

  MyPageModel _mapJsonToMypageModel(List<Map<String, dynamic>> jsonData) {
    final userProfileData = jsonData[0];

    return MyPageModel(
      userId: userProfileData['user_id'],
      nickname: userProfileData['nickname'],
      email: userProfileData['email'],
    );
  }
}
