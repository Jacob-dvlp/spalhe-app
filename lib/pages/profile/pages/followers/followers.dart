import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spalhe/components/layout/list_view_wraper/list_view.dart';
import 'package:spalhe/components/layout/loading/loading.dart';
import 'package:spalhe/components/layout/user_card/user_card.dart';
import 'package:spalhe/controllers/follows.controller.dart';
import 'package:spalhe/theme/colors.dart';

class FollowersPage extends StatelessWidget {
  final _followsController = Get.put(FollowsController());
  final int userId;

  FollowersPage({required this.userId}) {
    _followsController.getFollowers(userId);
  }

  @override
  Widget build(BuildContext context) {
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
          body: SafeArea(
            child: ListViewWraper(
              onRefresh: () async {},
              children: List.generate(
                followers.length,
                (index) {
                  final user = followers[index].follower;
                  return UserCard(
                    user: user!,
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
