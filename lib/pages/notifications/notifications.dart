import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spalhe/components/layout/image/image.dart';
import 'package:spalhe/components/layout/list_view_wraper/list_view.dart';
import 'package:spalhe/controllers/notification.controller.dart';
import 'package:spalhe/utils/date.dart';
import 'package:visibility_detector/visibility_detector.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(
      init: NotificationController(),
      builder: (ntf) {
        final notifications = ntf.notifications;

        return Scaffold(
          appBar: AppBar(
            title: Text('notificações'),
          ),
          body: VisibilityDetector(
            onVisibilityChanged: (info) => print(info.visibleBounds.right),
            key: Key("unique key"),
            child: ListViewWraper(
              padding: EdgeInsets.all(16),
              children: List.generate(
                notifications.length,
                (index) {
                  final notification = notifications[index];

                  return Opacity(
                    opacity: notification.viewed == true ? 0.5 : 1,
                    child: Container(
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: ImageNetwork(
                                        src: notification.user?.avatar ?? '',
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "@" +
                                            (notification.user?.username ?? ''),
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        notification.body ?? '',
                                        style: TextStyle(),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(height: 4),
                              Opacity(
                                opacity: 0.4,
                                child: Text(
                                  fromNow(notification.createdAt),
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
