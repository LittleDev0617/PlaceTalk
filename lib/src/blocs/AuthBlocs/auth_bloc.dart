import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:placetalk/src/models/UserAuthStatusModel.dart';

import '../../models/UserModel.dart';
import '../../repositories/AutoRepo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo _authRepo;

  AuthBloc(this._authRepo) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});

    on<RequestKakaoLogin>((event, emit) async {
      emit(AuthLoding());

      try {
        final status = await _authRepo.kakaoLogin();
        if (status == UserAuthStatusModel.granted) {
          final user = await _authRepo.kakaoGetUsers();
          _authRepo.getCookieFromHeader();
          emit(AuthGranted(user: user));
        } else if (status == UserAuthStatusModel.denied) {
          emit(AuthDenied());
        }
      } catch (e) {
        rethrow;
      }
    });

    on<RequestKakaoLogout>((event, emit) async {
      await _authRepo.kakaoLogout();
      emit(AuthDenied());
    });
  }
}

//Observer
class AuthBlocObserver extends BlocObserver {
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
