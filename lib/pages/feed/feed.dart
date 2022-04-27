import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spalhe/components/layout/avatar/avatar.dart';
import 'package:spalhe/components/layout/image/image.dart';
import 'package:spalhe/components/layout/story_maker/story_maker.dart';
import 'package:spalhe/controllers/auth.controller.dart';
import 'package:spalhe/controllers/posts.controller.dart';
import 'package:spalhe/pages/feed/post_item/post_item.dart';
import 'package:spalhe/pages/new_post/new_post.dart';
import 'package:spalhe/pages/profile/profile.dart';
import 'package:spalhe/theme/colors.dart';
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
                  Opacity(
                    opacity: 0.6,
                    child: Text(
                      'olá,',
                      style: TextStyle(fontSize: 12),
                    ),
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
            onPressed: () => OnRoute.push(NewPostPage()),
            icon: Icon(FeatherIcons.edit),
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: primary, width: 2),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final picker = ImagePicker();
                          await picker
                              .pickImage(source: ImageSource.gallery)
                              .then(
                            (file) async {
                              final File editedFile =
                                  await OnRoute.push(StoryMaker(
                                filePath: file!.path,
                              ));
                              print(editedFile);
                            },
                          );
                        },
                        child: Avatar(
                          user: user,
                          width: 50,
                          heigth: 50,
                          showIcon: false,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: primary,
                          ),
                          child: Icon(
                            Icons.add,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
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
