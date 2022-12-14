import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spalhe/components/layout/image/image.dart';
import 'package:spalhe/components/layout/list_view_wraper/list_view.dart';
import 'package:spalhe/controllers/notification.controller.dart';
import 'package:spalhe/models/notification.model.dart';
import 'package:spalhe/pages/post/post.dart';
import 'package:spalhe/pages/user/user.dart';
import 'package:spalhe/theme/colors.dart';
import 'package:spalhe/utils/date.dart';
import 'package:spalhe/utils/routes.dart';
import 'package:visibility_detector/visibility_detector.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  openNotification(INotification notification) {
    if (notification.type == 'post' && notification.post != null) {
      OnRoute.push(PostPage(post: notification.post!));
    }
    if (notification.type == 'follow') {
      OnRoute.push(UserPage(userId: notification.user!.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(
      init: NotificationController(),
      builder: (ntf) {
        final notifications = ntf.notifications;

        return Scaffold(
          appBar: AppBar(
            title: Text('notifications'.tr),
          ),
          body: VisibilityDetector(
            onVisibilityChanged: (info) {
              if (info.visibleBounds.right == 0) {
                ntf.readAll();
              }
            },
            key: Key("unique key"),
            child: ListViewWraper(
              onRefresh: () async {
                return ntf.getNotifications();
              },
              children: List.generate(
                notifications.length,
                (index) {
                  final notification = notifications[index];

                  return GestureDetector(
                    onTap: () => openNotification(notification),
                    child: Stack(
                      children: [
                        Container(
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
                              Flexible(
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 20,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: ImageNetwork(
                                          src: notification.user?.avatar ?? '',
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "@${notification.title}",
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            "${notification.body}",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
                        ),
                        if (notification.viewed == false)
                          Container(
                            width: 6,
                            height: 6,
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: primary,
                            ),
                          ),
                      ],
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
