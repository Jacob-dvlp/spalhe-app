import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:spalhe/controllers/home/home.dart';
import 'package:spalhe/controllers/messages/chat.dart';
import 'package:spalhe/controllers/notifications/notifications.dart';
import 'package:spalhe/pages/explore/explore.dart';
import 'package:spalhe/pages/messages/chat.dart';
import 'package:spalhe/pages/notifications/notifications.dart';
import 'package:spalhe/pages/posts/posts.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:spalhe/pages/profile/profile.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (_) => Scaffold(
        body: IndexedStack(
          index: _.tabIndex,
          children: <Widget>[
            PostPage(),
            const ExplorePage(),
            const ChatPage(),
            NotificationsPage(active: _.tabIndex == 3),
            ProfilePage(),
          ],
        ),
        backgroundColor: Theme.of(context).primaryColorLight,
        bottomNavigationBar: SafeArea(
          child: SalomonBottomBar(
            selectedColorOpacity: 0.04,
            currentIndex: _.tabIndex,
            onTap: (index) => _.changeTab(index),
            items: [
              SalomonBottomBarItem(
                icon: const Icon(FeatherIcons.home, size: 23),
                title: const Text("Feed"),
                selectedColor: Colors.purple,
              ),
              SalomonBottomBarItem(
                icon: const Icon(FeatherIcons.hash, size: 23),
                title: const Text("Descubra"),
                selectedColor: Colors.orange,
              ),
              SalomonBottomBarItem(
                icon: GetBuilder<ChatController>(
                  init: ChatController(),
                  builder: (_) => Stack(
                    children: <Widget>[
                      const Icon(FeatherIcons.messageCircle),
                      if (_.getTotal() != '0')
                        Positioned(
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 14,
                              minHeight: 14,
                            ),
                            child: Text(
                              _.getTotal(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                    ],
                  ),
                ),
                title: const Text("Chat"),
                selectedColor: Colors.red,
              ),
              SalomonBottomBarItem(
                icon: GetBuilder<NotificationsController>(
                  init: NotificationsController(),
                  builder: (_) => Stack(
                    children: <Widget>[
                      const Icon(Icons.favorite_outline),
                      if (_.getTotal() != '0')
                        Positioned(
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 14,
                              minHeight: 14,
                            ),
                            child: Text(
                              _.getTotal(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                    ],
                  ),
                ),
                title: const Text("Notificações"),
                selectedColor: Colors.pink,
                activeIcon: const Icon(Icons.favorite),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
