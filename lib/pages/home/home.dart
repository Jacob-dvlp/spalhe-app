import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spalhe/components/bottom_bar/bottom_bar.dart';
import 'package:spalhe/controllers/tabs.controller.dart';
import 'package:spalhe/pages/feed/feed.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<TabsController>(builder: (tab) {
        return IndexedStack(
          index: tab.index,
          children: [
            FeedPage(),
            Container(),
            Container(),
            Container(),
          ],
        );
      }),
      bottomNavigationBar: BottomNavigationComponent(),
    );
  }
}
