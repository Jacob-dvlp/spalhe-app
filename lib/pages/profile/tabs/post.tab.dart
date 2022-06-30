import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:spalhe/controllers/posts.controller.dart';
import 'package:spalhe/pages/feed/post_item/post_item.dart';

class PostTab extends StatelessWidget {
  const PostTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder<PostController>(
        init: PostController(),
        builder: (_posts) {
          final posts = _posts.userPost?.data;
          final totalPosts = posts?.length ?? 0;

          return Column(
            children: List.generate(
              totalPosts,
              (index) => PostItem(post: posts![index]),
            ),
          );
        },
      ),
    );
  }
}
