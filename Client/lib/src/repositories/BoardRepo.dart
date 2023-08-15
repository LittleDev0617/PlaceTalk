import '../models/BoardModel.dart';
import 'SessionRepo.dart';

class BoardRepo {
  final SessionRepo _sessionRepo;

  BoardRepo(this._sessionRepo);

  Future<List<BoardModel>> fetchBoardData(int placeID) async {
    await Future.delayed(const Duration(seconds: 1));
    final apiData = await _sessionRepo
        .get('api/posts?place_id=$placeID'); // Update the API endpoint

    List<BoardModel> boardList = List<BoardModel>.from(
        apiData.map((jsonData) => _mapJsonToBoardModel(jsonData)));

    return boardList;
  }

  // Future<List<BoardModel>> fetchPostDetailData(int placeID) async {
  //   await Future.delayed(const Duration(seconds: 1));

  //   final apiData = await _sessionRepo
  //       .get('api/boards?place_id=$placeID'); // Update the API endpoint

  //   List<BoardModel> boardList = List<BoardModel>.from(
  //       apiData.map((jsonData) => _mapJsonToBoardModel(jsonData)));

  //   return boardList;
  // }

  BoardModel _mapJsonToBoardModel(Map<String, dynamic> jsonData) {
    final userData = jsonData['user'];

    return BoardModel(
      postId: jsonData['post_id'],
      createDate: jsonData['create_date'],
      content: jsonData['content'],
      likes: jsonData['likes'],
      commentCnt: jsonData['commentCnt'],
      user: UserModel(
        userId: userData['user_id'],
        nickname: userData['nickname'],
        email: userData['email'],
      ),
    );
  }
}
