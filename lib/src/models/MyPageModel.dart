class MyPageModel {
  final int userId;
  final String nickname;
  final String email;

  MyPageModel({
    required this.userId,
    required this.nickname,
    required this.email,
  });

  factory MyPageModel.fromJson(Map<String, dynamic> json) {
    return MyPageModel(
      userId: json['user_id'],
      nickname: json['nickname'],
      email: json['email'],
    );
  }
}
