import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:spalhe/components/avatar/avatar.dart';
import 'package:spalhe/components/errors/errors.dart';
import 'package:spalhe/controllers/auth/auth.dart';
import 'package:spalhe/controllers/posts/posts.dart';
import 'package:spalhe/pages/moments/moment-list.dart';
import 'package:spalhe/pages/newpost/newpost.dart';
import 'package:spalhe/pages/posts/components/postItem.dart';
import 'package:spalhe/pages/profile/profile.dart';
import 'package:spalhe/pages/search/search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostPage extends StatelessWidget {
  PostPage({Key? key}) : super(key: key);
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final user = authController.auth['user'];

    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () => Get.to(ProfilePage()),
          child: Row(
            children: [
              Avatar(
                url: user['avatar'],
                width: 30,
                height: 30,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Olá',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    user['name'],
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => Get.to(SearchPage()),
            icon: const Icon(
              FeatherIcons.search,
            ),
          ),
          IconButton(
            onPressed: () => Get.to(NewPostPage()),
            icon: const Icon(
              FeatherIcons.edit,
            ),
          ),
        ],
      ),
      body: GetBuilder<PostsController>(
        init: PostsController(),
        builder: (_) => RefreshIndicator(
          onRefresh: () async {
            _.getPosts();
            _.getMoments();
          },
          color: Colors.teal,
          child: ListView(
            children: [
              MomentList(),
              if (_.loading)
                const Padding(
                  padding: EdgeInsets.all(28.0),
                  child: Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                      ),
                    ),
                  ),
                ),
              if (!_.loading && _.posts.isEmpty)
                const Errors(
                  icon: 'empty',
                  title: 'Você não tem nenhuma publicação',
                  description: 'Siga novas pessoas ou crie uma nova publicação',
                ),
              Column(
                children: List.generate(
                  _.posts.length,
                  (index) => PostItem(post: _.posts[index]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
