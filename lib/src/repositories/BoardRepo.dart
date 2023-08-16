import '../models/BoardModel.dart';
import 'SessionRepo.dart';

class BoardRepo {
  final SessionRepo _sessionRepo;

  BoardRepo(this._sessionRepo);

  Future<List<BoardModel>> fetchBoardData(int placeID) async {
    final apiData = await _sessionRepo.get('api/posts?place_id=$placeID');

    List<BoardModel> boardList = List<BoardModel>.from(
        apiData.map((jsonData) => _mapJsonToBoardModel(jsonData)));

    return boardList;
  }

  Future<List<BoardModel>> fetchLikeOrderData(int placeID, int order) async {
    final apiData = await _sessionRepo.get(
        'api/posts?place_id=$placeID&likeOrder=$order'); // Update the API endpoint

    List<BoardModel> boardList = List<BoardModel>.from(
        apiData.map((jsonData) => _mapJsonToBoardModel(jsonData)));

    return boardList;
  }

  BoardModel _mapJsonToBoardModel(Map<String, dynamic> jsonData) {
    final userData = jsonData['user'];

    return BoardModel(
      postId: jsonData['post_id'],
      createDate: jsonData['create_date'],
      content: jsonData['content'],
      likes: jsonData['likes'],
      commentCnt: jsonData['commentCnt'],
      isPressLike: jsonData['isPressLike'],
      user: ProfileModel(
        userId: userData['user_id'],
        nickname: userData['nickname'],
        email: userData['email'],
      ),
    );
  }
}
