import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:spalhe/components/skeletons/post_skeleton/post_skeleton.dart';
import 'package:spalhe/controllers/posts.controller.dart';
import 'package:spalhe/components/layout/post_item/post_item.dart';

class PostTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder<PostController>(
        init: PostController(),
        builder: (controller) {
          final posts = controller.userPost.data;
          final totalPosts = posts?.length ?? 0;
          final loading = controller.loading;

          if (loading)
            return Column(
              children: List.generate(2, (index) => PostSkeleton()),
            );

          if (totalPosts == 0 && !loading) {
            return Opacity(
              opacity: 0.6,
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                  ),
                  Text(
                    'nenhuma publicação encontrada',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 150),
                ],
              ),
            );
          }

          return Column(
            children: List.generate(
              posts?.length ?? 0,
              (index) => PostItem(post: posts![index]),
            ),
          );
        },
      ),
    );
  }
}
