part of 'main_bloc.dart';

abstract class MainBlocEvent extends Equatable {
  const MainBlocEvent();

  @override
  List<Object> get props => [];
}

class RequestKakaoLogin extends MainBlocEvent {}

class RequestKakaoLogout extends MainBlocEvent {}
