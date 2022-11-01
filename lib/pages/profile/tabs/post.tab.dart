import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:spalhe/controllers/posts.controller.dart';
import 'package:spalhe/components/layout/post_item/post_item.dart';

class PostTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder<PostController>(
        init: PostController(),
        builder: (controller) {
          final posts = controller.userPost?.data;
          final totalPosts = posts?.length ?? 0;

          if (totalPosts == 0) {
            return Column(
              children: [
                SizedBox(
                  height: 50,
                  width: double.infinity,
                ),
                SvgPicture.asset(
                  'assets/svg/feed.svg',
                  width: 200,
                ),
                SizedBox(height: 20),
                Text(
                  'Nenhuma publicação encontrada',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 150),
              ],
            );
          }

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
