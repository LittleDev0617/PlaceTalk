import '../models/CommentModel.dart';
import 'SessionRepo.dart';

class CommentRepo {
  final SessionRepo _sessionRepo;

  CommentRepo(this._sessionRepo);

  Future<List<CommentModel>> fetchCommentData(int postId) async {
    final apiData = await _sessionRepo
        .get('api/comments?post_id=$postId'); // Update the API endpoint

    List<CommentModel> commentList = List<CommentModel>.from(
        apiData.map((jsonData) => _mapJsonToCommentModel(jsonData)));

    return commentList;
  }

  CommentModel _mapJsonToCommentModel(Map<String, dynamic> jsonData) {
    final userData = jsonData['user'];

    return CommentModel(
      commentId: jsonData['comment_id'],
      postId: jsonData['post_id'],
      content: jsonData['content'],
      isReply: jsonData['is_reply'],
      replyId: jsonData['reply_id'],
      createDate: jsonData['create_date'],
      likes: jsonData['likes'],
      user: ProfileModel(
        userId: userData['user_id'],
        nickname: userData['nickname'],
        email: userData['email'],
      ),
    );
  }
}
