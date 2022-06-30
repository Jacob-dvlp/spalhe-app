import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:spalhe/controllers/posts.controller.dart';
import 'package:spalhe/pages/feed/post_item/post_item.dart';
import 'package:spalhe/pages/users/users.dart';
import 'package:spalhe/utils/routes.dart';

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
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => OnRoute.push(UsersPage()),
                  child: Text('encontrar amigos'),
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
