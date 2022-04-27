import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:spalhe/components/layout/image/image.dart';
import 'package:spalhe/controllers/auth.controller.dart';
import 'package:spalhe/controllers/posts.controller.dart';
import 'package:spalhe/pages/feed/post_item/post_item.dart';
import 'package:spalhe/pages/profile/profile.dart';
import 'package:spalhe/utils/routes.dart';

class FeedPage extends StatelessWidget {
  FeedPage({Key? key}) : super(key: key);

  final _auth = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final user = _auth.auth.user;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 6,
        title: GestureDetector(
          onTap: () => OnRoute.push(ProfilePage()),
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
                  Text(
                    'Olá',
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    'Thiago',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              )
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(FeatherIcons.edit),
          ),
        ],
      ),
      body: ListView(
        children: [
          Row(
            children: [],
          ),
          GetBuilder<PostController>(
            init: PostController(),
            builder: (_posts) {
              final posts = _posts.posts?.data;
              final totalPosts = posts?.length ?? 0;

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
    );
  }
}
