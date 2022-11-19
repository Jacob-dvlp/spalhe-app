import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:spalhe/controllers/chat.controller.dart';
import 'package:spalhe/controllers/notification.controller.dart';
import 'package:spalhe/controllers/tabs.controller.dart';

class BottomNavigationComponent extends StatelessWidget {
  const BottomNavigationComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GetBuilder<TabsController>(
      builder: (tab) {
        return Container(
          decoration: BoxDecoration(
            color: theme.cardColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 6,
                offset: Offset(0, -6),
              ),
            ],
          ),
          child: SalomonBottomBar(
            currentIndex: tab.index,
            onTap: tab.changeIndex,
            items: [
              SalomonBottomBarItem(
                title: Text('home'.tr),
                icon: Icon(FeatherIcons.home),
                selectedColor: theme.primaryColorDark,
              ),
              SalomonBottomBarItem(
                title: Text('explore'.tr),
                icon: Icon(FeatherIcons.hash),
                selectedColor: theme.primaryColorDark,
              ),
              SalomonBottomBarItem(
                title: Text('play'.tr),
                icon: Icon(FeatherIcons.playCircle),
                selectedColor: Colors.amber,
              ),
              SalomonBottomBarItem(
                title: Text('chat'.tr),
                selectedColor: theme.primaryColorDark,
                icon: GetBuilder<ChatController>(
                    init: ChatController(),
                    builder: (chatController) {
                      final chats = chatController.chats.getChats ?? [];
                      final chatUnread = chats
                          .where((el) => (el.countUnreadMessages ?? 0) > 0)
                          .toList();
                      return Stack(
                        children: <Widget>[
                          Icon(FeatherIcons.messageCircle),
                          if (chatUnread.length > 0)
                            Positioned(
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                constraints: BoxConstraints(
                                  minWidth: 12,
                                  minHeight: 12,
                                ),
                                child: Text(
                                  '${chatUnread.length}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                        ],
                      );
                    }),
              ),
              SalomonBottomBarItem(
                title: Text('notifications'.tr),
                selectedColor: Colors.redAccent,
                icon: GetBuilder<NotificationController>(
                  init: NotificationController(),
                  builder: (notificationControlelr) {
                    final notifications = notificationControlelr.notifications;

                    final notificationsUnread = notifications
                        .where((el) => (el.viewed ?? false) == false)
                        .toList();

                    return Stack(
                      children: <Widget>[
                        Icon(FeatherIcons.heart),
                        if (notificationsUnread.length > 0)
                          Positioned(
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              constraints: BoxConstraints(
                                minWidth: 12,
                                minHeight: 12,
                              ),
                              child: Text(
                                '${notificationsUnread.length}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
