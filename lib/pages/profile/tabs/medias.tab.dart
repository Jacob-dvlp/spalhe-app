import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spalhe/components/layout/image/image.dart';
import 'package:spalhe/controllers/posts.controller.dart';
import 'package:spalhe/pages/post/post.dart';
import 'package:spalhe/utils/routes.dart';

class MediasTab extends StatelessWidget {
  final PostController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          crossAxisSpacing: 0.5,
          mainAxisSpacing: 0.5,
        ),
        children: List.generate(
          controller.postMedias.data?.length ?? 0,
          (index) {
            final media = controller.postMedias.data?[index];

            return GestureDetector(
              onTap: () => OnRoute.push(
                PostPage(post: media!),
              ),
              child: Container(
                child: ImageNetwork(
                  src: (media?.medias?.length ?? 0) > 0
                      ? media?.medias?.first.thumb ?? media?.medias?.first.url
                      : '',
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
