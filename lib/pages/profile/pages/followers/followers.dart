import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spalhe/components/layout/avatar/avatar.dart';
import 'package:spalhe/components/layout/list_view_wraper/list_view.dart';
import 'package:spalhe/components/layout/loading/loading.dart';
import 'package:spalhe/controllers/auth.controller.dart';
import 'package:spalhe/controllers/follows.controller.dart';
import 'package:spalhe/pages/profile/profile.dart';
import 'package:spalhe/pages/user/user.dart';
import 'package:spalhe/theme/colors.dart';
import 'package:spalhe/utils/routes.dart';

class FollowersPage extends StatelessWidget {
  final _followsController = Get.put(FollowsController());
  final int userId;

  FollowersPage({required this.userId}) {
    _followsController.getFollowers(userId);
  }

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());
    final authuser = authController.auth.user;

    return GetBuilder<FollowsController>(
      init: FollowsController(),
      builder: (controller) {
        final isLoading = controller.isLoading;
        final followers = controller.followers;

        if (isLoading) {
          return Scaffold(
            appBar: AppBar(
              title: Text('seguidores'),
            ),
            body: Center(
              child: Loading(
                color: primary,
              ),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('seguidores'),
          ),
          body: Container(
            padding: EdgeInsets.only(top: 10),
            child: ListViewWraper(
              onRefresh: () async {},
              children: List.generate(
                followers.length,
                (index) {
                  final user = followers[index].follower;

                  return InkWell(
                    onTap: () {
                      if (authuser?.id == user?.id) {
                        OnRoute.push(ProfilePage());
                      } else {
                        OnRoute.push(UserPage(
                          userId: user!.id!,
                        ));
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          Avatar(
                            user: user,
                            heigth: 45,
                            width: 45,
                            iconSize: 15,
                          ),
                          SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user?.name ?? '',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Opacity(
                                opacity: 0.6,
                                child: Text(
                                  '@${user?.username ?? ''}',
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                              )
                            ],
                          )
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
