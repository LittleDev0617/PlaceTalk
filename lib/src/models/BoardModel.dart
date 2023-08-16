class BoardModel {
  final int postId;
  final String createDate;
  final String content;
  final int likes;
  final int commentCnt;
  final bool isPressLike;
  final ProfileModel user;

  BoardModel({
    required this.postId,
    required this.createDate,
    required this.content,
    required this.likes,
    required this.isPressLike,
    required this.commentCnt,
    required this.user,
  });
}

class ProfileModel {
  final int userId;
  final String nickname;
  final String email;

  ProfileModel({
    required this.userId,
    required this.nickname,
    required this.email,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      userId: json['user_id'],
      nickname: json['nickname'],
      email: json['email'],
    );
  }
}
