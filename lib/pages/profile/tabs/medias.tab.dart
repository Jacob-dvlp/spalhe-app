import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spalhe/components/layout/image/image.dart';
import 'package:spalhe/controllers/posts.controller.dart';
import 'package:spalhe/pages/post/post.dart';
import 'package:spalhe/utils/routes.dart';

class MediasTab extends StatelessWidget {
  final String? tag;

  MediasTab({this.tag});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostController>(
      tag: tag,
      builder: (controller) => GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
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
