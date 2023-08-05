import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String? email;
  final int kakaoID;

  const UserModel({this.email, required this.kakaoID});

  @override
  List<Object?> get props => [email, kakaoID];
}
