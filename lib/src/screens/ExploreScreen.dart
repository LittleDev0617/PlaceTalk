import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/buttons.dart';

@RoutePage()
class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ExplorePage();
  }
}

class ExplorePage extends StatelessWidget {
  const ExplorePage({
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
              '인기장소 둘러보기',
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
      body: StackedCardPage(),
    );
  }
}

class StackedCardPage extends StatefulWidget {
  @override
  _StackedCardPageState createState() => _StackedCardPageState();
}

class _StackedCardPageState extends State<StackedCardPage> {
  PageController _pageController = PageController(viewportFraction: 0.8);
  double _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page ?? 0;
      });
    });
  }

  void _onPageChanged(int index) {
    if (_pageController.page != index.toDouble()) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      itemCount: 10,
      onPageChanged: _onPageChanged,
      itemBuilder: (BuildContext context, int index) {
        double delta = index - _currentPage;

        if (delta > 0) {
        } else {}

        double translateY = delta * 20; // Adjust as needed

        return Center(
          child: GestureDetector(
            onTap: () {
              // Handle card tap if needed
            },
            child: Transform.translate(
              offset: Offset(0, translateY),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('분류', style: TextStyle(fontSize: 18)),
                      Text(
                        '제목',
                        style: TextStyle(
                            fontSize: 22,
                            letterSpacing: -1,
                            fontWeight: FontWeight.w500),
                      ),
                      Text('기한',
                          style: TextStyle(fontSize: 16, color: Colors.grey)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
