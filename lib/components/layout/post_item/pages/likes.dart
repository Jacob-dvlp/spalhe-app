import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spalhe/components/layout/list_view_wraper/list_view.dart';
import 'package:spalhe/components/layout/loading/loading.dart';
import 'package:spalhe/components/layout/user_card/user_card.dart';
import 'package:spalhe/controllers/likes_in_post.controller.dart';
import 'package:spalhe/theme/colors.dart';

class LikesInPostPage extends StatelessWidget {
  LikesInPostPage({
    required this.postId,
  }) {
    final postItemController =
        Get.put(LikesInPostController(), tag: postId.toString());
    postItemController.getLikesInPost(postId);
  }

  final int postId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('quem gostou'),
      ),
      body: GetBuilder<LikesInPostController>(
          tag: postId.toString(),
          init: LikesInPostController(),
          builder: (controlelr) {
            final userLiked = controlelr.userLikes.getPostLikes ?? [];
            final loading = controlelr.loading;

            if (loading) {
              return Center(
                child: Loading(
                  color: primary,
                ),
              );
            }

            return Container(
              padding: EdgeInsets.only(top: 10),
              child: ListViewWraper(
                onRefresh: () async {
                  controlelr.getLikesInPost(postId);
                },
                children: List.generate(
                  userLiked.length,
                  (index) {
                    final user = userLiked[index].user;
                    return UserCard(user: user!);
                  },
                ),
              ),
            );
          }),
    );
  }
}
