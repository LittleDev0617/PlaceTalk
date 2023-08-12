part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class RequestKakaoLogin extends AuthEvent {}

class RequestKakaoLogout extends AuthEvent {}
