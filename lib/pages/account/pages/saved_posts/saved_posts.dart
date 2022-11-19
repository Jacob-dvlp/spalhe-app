import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spalhe/components/layout/post_item/post_item.dart';
import 'package:spalhe/controllers/saved_posts.controller.dart';

class SavedPostsPage extends StatelessWidget {
  const SavedPostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SavedPostsController>(
      init: SavedPostsController(),
      builder: (controller) {
        final posts = controller.savedPosts;

        return Scaffold(
          appBar: AppBar(
            title: Text('saved_posts'.tr),
          ),
          body: controller.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    controller.getPosts();
                  },
                  child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      return PostItem(
                        post: post,
                      );
                    },
                  ),
                ),
        );
      },
    );
  }
}
