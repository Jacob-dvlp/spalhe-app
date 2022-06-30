import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:spalhe/components/layout/image/image.dart';
import 'package:spalhe/controllers/posts.controller.dart';
import 'package:spalhe/models/post.model.dart';
import 'package:spalhe/pages/post/post.dart';
import 'package:spalhe/utils/routes.dart';

class MediasTab extends StatelessWidget {
  const MediasTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostController>(
      builder: (controller) => GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        children: List.generate(
          controller.postMedias.length,
          (index) => GestureDetector(
            onTap: () => OnRoute.push(
              PostPage(post: controller.postMedias[index]),
            ),
            child: Container(
              child: ImageNetwork(
                src: controller.postMedias[index].medias?.first.url,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
