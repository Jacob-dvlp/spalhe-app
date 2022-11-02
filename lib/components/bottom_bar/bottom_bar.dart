import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:spalhe/controllers/chat.controller.dart';
import 'package:spalhe/controllers/notification.controller.dart';
import 'package:spalhe/controllers/tabs.controller.dart';

class BottomNavigationComponent extends StatelessWidget {
  const BottomNavigationComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TabsController>(builder: (tab) {
      return BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 22,
        type: BottomNavigationBarType.fixed,
        currentIndex: tab.index,
        onTap: tab.changeIndex,
        elevation: 10,
        unselectedLabelStyle: TextStyle(fontSize: 0),
        selectedLabelStyle: TextStyle(fontSize: 0),
        items: [
          BottomNavigationBarItem(
            label: '',
            icon: Icon(FeatherIcons.home),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(FeatherIcons.search),
          ),
          BottomNavigationBarItem(
            label: '',
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
                              color: Colors.red,
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
          BottomNavigationBarItem(
            label: '',
            icon: GetBuilder<NotificationController>(
                init: NotificationController(),
                builder: (notificationControlelr) {
                  final notifications = notificationControlelr.notifications;

                  final notificationsUnread = notifications
                      .where((el) => (el.viewed ?? false) == false)
                      .toList();

                  return Stack(
                    children: <Widget>[
                      Icon(FeatherIcons.bell),
                      if (notificationsUnread.length > 0)
                        Positioned(
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              color: Colors.red,
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
                }),
          ),
        ],
      );
    });
  }
}
