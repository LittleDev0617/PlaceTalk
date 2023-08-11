import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:placex/src/blocs/mainBlocs/main_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'routes/app_router.dart.gr.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 716),
      builder: (context, child) {
        return const LoginPage();
      },
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '일상 속 모든 핫플',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 25.sp,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              '플레이스톡 하나로',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 26.sp,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 45.h),
            Text(
              '축제는 물론 콘서트, 팝업스토어까지!',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
                color: Colors.white,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.32),
          ],
        ),
      ),
      floatingActionButton: BlocListener<MainBloc, MainBlocState>(
        listener: (context, state) {
          if (state is RequestKakaoLoginGranted) {
            context.router.root.replace(const HomeRoute());
          }
        },
        child: FloatingActionButton.extended(
          onPressed: () {
            BlocProvider.of<MainBloc>(context).add(
              RequestKakaoLogin(),
            );
          },
          label: Image.asset(
            'assets/images/kakao_login.png',
            fit: BoxFit.cover,
          ),
          backgroundColor: Colors.transparent,
          elevation: 4,
        ),
      ),
    );
  }
}
