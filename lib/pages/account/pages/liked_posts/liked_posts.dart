import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spalhe/components/layout/post_item/post_item.dart';
import 'package:spalhe/controllers/liked_posts.dart';

class LikedPostsPage extends StatelessWidget {
  LikedPostsPage() {
    final likedPostsController = Get.put(LikedPostsController());

    likedPostsController.getLikedPosts(1, {});
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LikedPostsController>(
      init: LikedPostsController(),
      builder: (likedController) {
        return Scaffold(
          appBar: AppBar(
            title: Text('publicações que eu curti'),
          ),
          body: ListView.builder(
            itemCount: likedController.posts.length,
            itemBuilder: (context, index) {
              return PostItem(
                post: likedController.posts[index],
              );
            },
          ),
        );
      },
    );
  }
}
