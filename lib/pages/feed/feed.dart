import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:spalhe/components/layout/image/image.dart';
import 'package:spalhe/controllers/auth.controller.dart';
import 'package:spalhe/controllers/posts.controller.dart';
import 'package:spalhe/pages/feed/moments/moments.dart';
import 'package:spalhe/pages/feed/post_item/post_item.dart';
import 'package:spalhe/pages/new_post/new_post.dart';
import 'package:spalhe/pages/profile/profile.dart';
import 'package:spalhe/pages/users/users.dart';
import 'package:spalhe/utils/routes.dart';

class FeedPage extends StatelessWidget {
  FeedPage({Key? key}) : super(key: key);

  final _auth = Get.put(AuthController());
  final _post = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    final user = _auth.auth.user;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 6,
        title: GestureDetector(
          onTap: () => OnRoute.push(ProfilePage(
            userId: user!.id!,
          )),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: ImageNetwork(
                  src: user?.avatar ?? '',
                  width: 40,
                  height: 40,
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Opacity(
                    opacity: 0.6,
                    child: Text(
                      'Olá,',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  Text(
                    'Thiago',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => OnRoute.push(NewPostPage()),
            icon: Icon(FeatherIcons.edit),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await _post.getPosts();
        },
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: MomentsComponent(),
            ),
            GetBuilder<PostController>(
              init: PostController(),
              builder: (_posts) {
                final posts = _posts.posts?.data;
                final totalPosts = posts?.length ?? 0;

                if (totalPosts == 0) {
                  return Column(
                    children: [
                      SizedBox(height: 50),
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
                      )
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
            )
          ],
        ),
      ),
    );
  }
}
