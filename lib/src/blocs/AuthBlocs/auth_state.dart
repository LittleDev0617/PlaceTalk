part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoding extends AuthState {}

class AuthGranted extends AuthState {
  final UserModel user;
  final String nickname;

  const AuthGranted({required this.user, required this.nickname});
}

class AuthDenied extends AuthState {}
