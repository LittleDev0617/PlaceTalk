import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:placetalk/src/blocs/AuthBlocs/auth_bloc.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: TextButton(
      onPressed: () {
        BlocProvider.of<AuthBloc>(context).add(
          RequestKakaoLogout(),
        );
      },
      child: const Text('로그아웃'),
    ));
  }
}
