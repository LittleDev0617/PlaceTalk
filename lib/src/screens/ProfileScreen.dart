import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/JoinBlocs/join_bloc.dart';
import '../components/buttons.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfilePage();
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(5.0),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.height * 0.2,
                pinned: true,
                leading: IconButton(
                  icon: const Icon(Icons.account_circle),
                  iconSize: 32,
                  onPressed: () {
                    // Profile icon tapped
                  },
                ),
                title: const Text(
                  '익명',
                  style: TextStyle(fontSize: 24),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.logout),
                    onPressed: () {
                      // Logout icon tapped
                    },
                  ),
                ],
                bottom: const TabBar(
                  tabs: [
                    Tab(text: '내가 쓴 글'),
                    Tab(text: '참여중인 장소'),
                  ],
                ),
              ),
              SliverFillRemaining(
                child: TabBarView(
                  children: [
                    Center(child: Text('탭1 내용')),
                    Center(
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
                            return ListView.builder(
                              itemCount: namesList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  title: Text(
                                    namesList[index],
                                    style: const TextStyle(
                                      letterSpacing: -1,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
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
                                      TextButton(
                                        onPressed: () {},
                                        child: const Text('나가기'),
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
