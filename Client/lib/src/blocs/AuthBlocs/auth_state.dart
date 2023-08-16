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

  const AuthGranted({required this.user});
}

class AuthDenied extends AuthState {}
