import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/buttons.dart';

@RoutePage()
class NoticeScreen extends StatelessWidget {
  const NoticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const NoticePage();
  }
}

class NoticePage extends StatelessWidget {
  const NoticePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '모든 공지',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
            CircleAvatarIconButton(
              backgroundColor: Colors.black87,
              iconColor: Colors.white,
              icon: Icons.notifications_rounded,
              onPressed: () {},
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(),
    );
  }
}
