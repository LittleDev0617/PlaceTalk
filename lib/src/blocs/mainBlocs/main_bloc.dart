import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:placex/src/models/kakaoUserLoginStatus.dart';
import 'package:placex/src/repositories/kakaoAuthRepo.dart';

import '../../models/usersModel.dart';

part 'main_bloc_event.dart';
part 'main_bloc_state.dart';

class MainBloc extends Bloc<MainBlocEvent, MainBlocState> {
  MainBloc() : super(MainBlocInitial()) {
    // on<MainBlocEvent>((event, emit) {
    // });
    on<RequestKakaoLogin>((event, emit) async {
      emit(RequestKakaoLoginLoding());

      //try 카카오 로그인 시도
      try {
        final status = await kakaoAuthRepo().kakaoLogin();
        if (status == kakaoUserLoginStatus.granted) {
          emit(RequestKakaoLoginGranted());
          final user = await kakaoAuthRepo().kakaoGetUsers();
          emit(MainBlocLoded(user: user));
        } else if (status == kakaoUserLoginStatus.denied) {
          emit(RequestKakaoLoginDenied());
        }
      } catch (e) {
        rethrow;
      }
    });

    on<RequestKakaoLogout>((event, emit) async {
      emit(RequestKakaoLoginDenied());
      await kakaoAuthRepo().kakaoLogin();
    });
  }
}

//Observer
class MainBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    if (kDebugMode) {
      print('onEvent: $event');
    }
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (kDebugMode) {
      print('onTransition: $transition');
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    if (kDebugMode) {
      print('onError: $error');
    }
  }
}
