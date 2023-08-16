class BoardModel {
  final int postId;
  final String createDate;
  final String content;
  final int likes;
  final int commentCnt;
  final UserModel user;

  BoardModel({
    required this.postId,
    required this.createDate,
    required this.content,
    required this.likes,
    required this.commentCnt,
    required this.user,
  });
}

class UserModel {
  final int userId;
  final String nickname;
  final String email;

  UserModel({
    required this.userId,
    required this.nickname,
    required this.email,
  });
}

// Now you can parse the JSON data into a list of BoardModel objects

List<BoardModel> fromJson(List<dynamic> jsonList) {
  return jsonList.map((json) {
    final userData = json['user'];
    return BoardModel(
      postId: json['post_id'],
      createDate: json['create_date'],
      content: json['content'],
      likes: json['likes'],
      commentCnt: json['commentCnt'],
      user: UserModel(
        userId: userData['user_id'],
        nickname: userData['nickname'],
        email: userData['email'],
      ),
    );
  }).toList();
}
