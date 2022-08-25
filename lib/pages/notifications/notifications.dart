import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spalhe/components/layout/image/image.dart';
import 'package:spalhe/components/layout/list_view_wraper/list_view.dart';
import 'package:spalhe/controllers/notification.controller.dart';
import 'package:spalhe/utils/date.dart';

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
          body: ListViewWraper(
            padding: EdgeInsets.all(16),
            children: List.generate(
              notifications.length,
              (index) {
                final notification = notifications[index];
                return Container(
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(10)),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    notification.user?.name ?? '',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Opacity(
                                    opacity: 0.6,
                                    child: Text(
                                      "@" + (notification.user?.username ?? ''),
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          Text(notification.body ?? ''),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(height: 4),
                          Opacity(
                            opacity: 0.4,
                            child: Text(
                              DateUtil.format('dd/MM', notification.createdAt),
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
