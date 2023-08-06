import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:placex/src/blocs/Exploreblocs/explore_bloc.dart';
import 'package:placex/src/blocs/JoinBlocs/join_bloc.dart';
import 'package:placex/src/blocs/boothBlocs/booth_bloc.dart';
import 'package:placex/src/blocs/mainBlocs/main_bloc.dart';
import 'package:placex/src/repositories/boothDataRepo.dart';

import 'package:placex/src/repositories/kakaoAuthRepo.dart';
import 'package:placex/src/repositories/placeDataRepo.dart';

import 'blocs/dropdownBlocs/dropdown_bloc.dart';

import 'blocs/placeBlocs/place_bloc.dart';
import 'screens/routes/app_router.dart.dart';

class App extends StatelessWidget {
  final _appRouter = AppRouter();

  App({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => kakaoAuthRepo()),
        RepositoryProvider(create: (context) => placeDataRepo()),
        RepositoryProvider(create: (context) => boothDataRepo()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => MainBloc()..add(RequestKakaoLogin())),
          BlocProvider(create: (context) => DropdownBloc()),
          BlocProvider(create: (context) => PlaceBloc(placeDataRepo())),
          BlocProvider(create: (context) => BoothBloc(boothDataRepo())),
          BlocProvider(create: (context) => JoinBloc(placeDataRepo())),
          BlocProvider(create: (context) => ExploreBloc(placeDataRepo())),
        ],
        child: ScreenUtilInit(
          designSize: const Size(360, 716),
          builder: (context, child) => MaterialApp.router(
            routerConfig: _appRouter.config(deepLinkBuilder: (deepLink) {
              if (deepLink.path.startsWith('/event')) {
                // continute with the platfrom link
                return deepLink;
              } else {
                return DeepLink.defaultPath;
              }
            }),
            theme: ThemeData(
              useMaterial3: true,
              fontFamily: 'Gmarket',
            ),
            debugShowCheckedModeBanner: false,
          ),
        ),
      ),
    );
  }
}
