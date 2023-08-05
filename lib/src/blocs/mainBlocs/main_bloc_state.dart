part of 'main_bloc.dart';

abstract class MainBlocState {}

class MainBlocInitial extends MainBlocState {}

class MainBlocLoding extends MainBlocState {} //카카오 로그인 확인

class MainBlocLoded extends MainBlocState {
  // 로그인 요청 정보 받아오기
  final UserModel user;

  MainBlocLoded({required this.user});
}

class RequestKakaoLoginLoding extends MainBlocState {}

class RequestKakaoLoginGranted extends MainBlocState {}

class RequestKakaoLoginDenied extends MainBlocState {}
