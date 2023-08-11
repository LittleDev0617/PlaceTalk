import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:placex/src/blocs/mainBlocs/main_bloc.dart';

import 'src/app.dart';

Future<void> main() async {
  initializeDateFormatting();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await NaverMapSdk.instance.initialize(clientId: 'q47bzi77m7');
  KakaoSdk.init(
    nativeAppKey: '5647f17b2edc4c4f4c69846166d6ecd3',
  );

  Bloc.observer = MainBlocObserver();

  runApp(App());
}
