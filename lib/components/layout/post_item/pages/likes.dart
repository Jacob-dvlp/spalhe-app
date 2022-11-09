import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spalhe/components/layout/avatar/avatar.dart';
import 'package:spalhe/components/layout/list_view_wraper/list_view.dart';
import 'package:spalhe/components/layout/loading/loading.dart';
import 'package:spalhe/controllers/auth.controller.dart';
import 'package:spalhe/controllers/likes_in_post.controller.dart';
import 'package:spalhe/pages/profile/profile.dart';
import 'package:spalhe/pages/user/user.dart';
import 'package:spalhe/theme/colors.dart';
import 'package:spalhe/utils/routes.dart';

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
    final authController = Get.put(AuthController());
    final authuser = authController.auth.user;

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
            );
          }),
    );
  }
}
