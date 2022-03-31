import 'package:flutter/material.dart';
import 'package:spalhe/components/bottom_bar/bottom_bar.dart';
import 'package:spalhe/pages/feed/feed.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: [
          FeedPage(),
          Container(),
          Container(),
          Container(),
        ],
      ),
      bottomNavigationBar: BottomNavigationComponent(),
    );
  }
}
