import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:placetalk/src/blocs/AuthBlocs/auth_bloc.dart';

import 'src/app.dart';
import 'src/blocs/PlaceBlocs/place_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  KakaoSdk.init(
    nativeAppKey: 'd43af145781de55f322d3323d1ad5a3c',
  );

  await NaverMapSdk.instance.initialize(clientId: 'xcckznajzm');

  Bloc.observer = AuthBlocObserver();
  Bloc.observer = PlaceBlocObserver();

  runApp(App());
}
