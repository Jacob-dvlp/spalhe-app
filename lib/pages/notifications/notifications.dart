import 'package:spalhe/components/avatar/avatar.dart';
import 'package:spalhe/controllers/notifications/notifications.dart';
import 'package:spalhe/pages/post/post.dart';
import 'package:spalhe/pages/user/user.dart';
import 'package:spalhe/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationsPage extends StatelessWidget {
  final active;
  NotificationsPage({Key? key, this.active}) : super(key: key);
  String getNotification(type) {
    final msg = {
          "like": 'curtiu sua publicação',
          "comment": 'comentou sua publicação',
          "reply": 'respondeu seu comentário',
          "share": 'spalhou sua publicação',
          "comment_like": 'curtiu seu comentário',
          "follow": 'seguiu você',
          "comment_moment": 'comentou seu moment',
          "like_moment": 'curtiu seu moment',
        }[type] ??
        '...';
    return msg;
  }

  void getRoute(post) {
    int postId = int.parse(post['post_id']);
    // int userId = post['user_id'];
    Function route = {
      "like": () => Get.to(PostPage(postId)),
      "comment": () => Get.to(PostPage(postId)),
      "reply": () => Get.to(PostPage(postId)),
      "share": () => Get.to(PostPage(postId)),
      "comment_likes": () => Get.to(PostPage(postId)),
      "follow": () => Get.to(UserPage(user: post['user'])),
    }[post['type']] as Function;
    route();
  }

  final NotificationsController ntfController =
      Get.put(NotificationsController());

  @override
  Widget build(BuildContext context) {
    if (active) {
      WidgetsBinding.instance?.addPostFrameCallback(
        (_) => ntfController.clearNotifications(),
      );
    }

    return GetBuilder<NotificationsController>(
      init: ntfController,
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Notificações'),
          centerTitle: false,
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            _.getAllNotifications();
          },
          color: Colors.teal,
          child: ListView(
            children: [
              const SizedBox(height: 20),
              Column(
                children: List.generate(_.notifications.length, (index) {
                  final notification = _.notifications[index];
                  var total = _.notifications
                      .where((el) => el['view'].toString() == '0')
                      .length
                      .toString();
                  return InkWell(
                    onTap: () => getRoute(notification),
                    child: Container(
                      margin: const EdgeInsets.only(top: 0.4),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(200),
                                child: Avatar(
                                  url: notification['user']['avatar'],
                                  width: 40.0,
                                  height: 40.0,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    notification['user']['name'],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    getNotification(notification['type']),
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .primaryColorDark
                                          .withOpacity(0.8),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          if (int.parse(total) > 0)
                            Container(
                              height: 8,
                              width: 8,
                              decoration: BoxDecoration(
                                color: const Color(0xff009688),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          Text(
                            Utils.date(notification['created_at']),
                            style: const TextStyle(
                              fontSize: 11,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
