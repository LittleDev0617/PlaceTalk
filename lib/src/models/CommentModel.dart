class CommentModel {
  final int commentId;
  final int postId;
  final String content;
  final int isReply;
  final int replyId;
  final String createDate;
  final int likes;
  final ProfileModel user;

  CommentModel({
    required this.commentId,
    required this.postId,
    required this.content,
    required this.isReply,
    required this.replyId,
    required this.createDate,
    required this.likes,
    required this.user,
  });
}

class CommentListModel {
  final List<CommentModel> comments;

  CommentListModel({required this.comments});

  factory CommentListModel.fromJson(List<dynamic> jsonList) {
    List<CommentModel> comments = jsonList.map((json) {
      final userData = json['user'];
      return CommentModel(
        commentId: json['comment_id'],
        postId: json['post_id'],
        content: json['content'],
        isReply: json['is_reply'],
        replyId: json['reply_id'],
        createDate: json['create_date'],
        likes: json['likes'],
        user: ProfileModel(
          userId: userData['user_id'],
          nickname: userData['nickname'],
          email: userData['email'],
        ),
      );
    }).toList();

    return CommentListModel(comments: comments);
  }
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
}
