import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spalhe/components/layout/loading/loading.dart';
import 'package:spalhe/components/layout/post_item/post_item.dart';
import 'package:spalhe/controllers/hashtags.controller.dart';
import 'package:spalhe/theme/colors.dart';

class HashtagsPostsPage extends StatelessWidget {
  final hashtagsController = Get.put(HashtagsController());
  HashtagsPostsPage({Key? key, required this.hashtag}) {
    hashtagsController.getPostsByHashTags(hashtag);
  }

  final String hashtag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('#${hashtag}'),
      ),
      body: GetBuilder<HashtagsController>(
        init: HashtagsController(),
        builder: (hashtagController) {
          final posts = hashtagController.posts.data ?? [];

          return ListView(
            padding: EdgeInsets.only(top: 10, bottom: 100),
            children: [
              if (posts.isEmpty)
                Center(
                  child: Loading(color: primary),
                ),
              ...List.generate(
                posts.length,
                (index) => PostItem(
                  post: posts[index],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
