import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:placex/src/blocs/mainBlocs/main_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    var medh = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFf093fb),
              Color(0xFFf5576c),
            ],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          children: [
            SizedBox(height: medh / 3),
            SizedBox(
              height: 30.h,
              child: Center(
                child: Text(
                  '일상 속 모든 핫플',
                  style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 21.sp),
                ),
              ),
            ),
            SizedBox(
              height: 35.h,
              child: Center(
                  child: Text('플레이스X 하나로',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 26.sp))),
            ),
            SizedBox(
              height: 35.h,
              child: Center(
                  child: Text('축제는 물론 콘서트, 팝업스토어까지!',
                      style: TextStyle(
                          fontWeight: FontWeight.w300, fontSize: 16.sp))),
            ),
          ],
        ),
      ),
      floatingActionButton: BlocBuilder<MainBloc, MainBlocState>(
        builder: (context, state) {
          if (state is MainBlocLoded) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              AutoRouter.of(context).pushNamed('/');
            });
            return GestureDetector(
              onTap: () {
                AutoRouter.of(context).pushNamed('/');
              },
              child: Container(
                width: double.infinity,
                height: 45,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: const Center(
                  child: Text(
                    '입장하기',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            );
          } else if (state is RequestKakaoLoginGranted) {
            return const CircularProgressIndicator(color: Colors.black);
          } else {
            return FloatingActionButton.extended(
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
              elevation: 0,
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
