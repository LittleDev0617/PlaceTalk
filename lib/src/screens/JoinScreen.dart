import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:placex/src/blocs/JoinBlocs/join_bloc.dart';

import '../components/buttons.dart';

@RoutePage()
class JoinScreen extends StatelessWidget {
  const JoinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const JoinPage();
  }
}

class JoinPage extends StatelessWidget {
  const JoinPage({
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
              '참여중인 장소',
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
      body: Center(
        child: BlocBuilder<JoinBloc, JoinBlocState>(
          builder: (context, state) {
            if (state is JoinInitial) {
              BlocProvider.of<JoinBloc>(context).add(
                FetchJoinDataEvent(),
              );
              return const CircularProgressIndicator();
            } else if (state is JoinDataLoading) {
              return const CircularProgressIndicator();
            } else if (state is JoinDataLoaded) {
              List<String> namesList = state.namesList;
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView.builder(
                  itemCount: namesList.length, // 생성할 아이템의 개수
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(
                        namesList[index],
                        style: const TextStyle(
                          letterSpacing: -1,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                      leading: Text(
                        '${index + 1}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 18,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatarIconButton(
                            backgroundColor: Colors.transparent,
                            iconColor: Colors.black87,
                            icon: Icons.list_alt_outlined,
                            onPressed: () {},
                          ),
                          CircleAvatarIconButton(
                            backgroundColor: Colors.transparent,
                            iconColor: Colors.black87,
                            icon: Icons.push_pin_outlined,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
