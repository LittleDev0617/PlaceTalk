import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:placetalk/src/blocs/AuthBlocs/auth_bloc.dart';
import 'package:placetalk/src/screens/routes/routes.gr.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthGranted) {
          context.router.root.replace(const LandingRoute());
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(.8),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '일상 속 모든 핫플',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    'assets/logos/logo.svg',
                    width: MediaQuery.of(context).size.width * .41,
                  ),
                  const SizedBox(width: 5.5),
                  Text(
                    '하나로',
                    style: TextStyle(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Text(
                '축제는 물론 콘서트, 팝업스토어까지',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withOpacity(.84),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            BlocProvider.of<AuthBloc>(context).add(
              RequestKakaoLogin(),
            );
          },
          label: Image.asset(
            'assets/images/kakao_login.png',
            fit: BoxFit.cover,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
