import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:spalhe/controllers/posts.controller.dart';
import 'package:spalhe/pages/feed/post_item/post_item.dart';

class PostMentionsTab extends StatelessWidget {
  const PostMentionsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder<PostController>(
        global: true,
        autoRemove: false,
        init: PostController(),
        builder: (_posts) {
          final posts = _posts.mentions;
          final totalPosts = posts?.data?.length ?? 0;

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
              (index) => PostItem(post: posts!.data![index]),
            ),
          );
        },
      ),
    );
  }
}
