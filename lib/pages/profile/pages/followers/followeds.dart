import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spalhe/components/layout/list_view_wraper/list_view.dart';
import 'package:spalhe/components/layout/loading/loading.dart';
import 'package:spalhe/components/layout/user_card/user_card.dart';
import 'package:spalhe/controllers/follows.controller.dart';
import 'package:spalhe/theme/colors.dart';

class FollowedsPage extends StatelessWidget {
  final _followsController = Get.put(FollowsController());
  final int userId;

  FollowedsPage({required this.userId}) {
    _followsController.getFolloweds(userId);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FollowsController>(
      init: FollowsController(),
      builder: (controller) {
        final isLoading = controller.isLoading;
        final followeds = controller.followeds;

        if (isLoading) {
          return Scaffold(
            appBar: AppBar(
              title: Text('following'.tr),
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
            title: Text('following'.tr),
          ),
          body: SafeArea(
            child: ListViewWraper(
              onRefresh: () async {},
              children: List.generate(
                followeds.length,
                (index) {
                  final user = followeds[index].followed;

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
