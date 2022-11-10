import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:spalhe/components/layout/image/image.dart';
import 'package:spalhe/controllers/explore.controller.dart';
import 'package:spalhe/pages/post/post.dart';
import 'package:spalhe/utils/routes.dart';
// import 'package:spalhe/components/layout/post_item/post_item.dart';

class ExploreMidias extends StatelessWidget {
  const ExploreMidias({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder<ExploreController>(
        init: ExploreController(),
        builder: (exploreController) {
          final medias = exploreController.postMedias?.data ?? [];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Get.theme.cardColor,
                child: Column(
                  children: [
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '+ fotos e vídeos',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // TextButton(onPressed: () {}, child: Text('ver mais'))
                        ],
                      ),
                    ),
                    Divider(),
                  ],
                ),
              ),
              new StaggeredGridView.countBuilder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 4,
                itemCount: medias.length,
                itemBuilder: (BuildContext context, index) {
                  final media = medias[index];

                  return GestureDetector(
                    onTap: () => OnRoute.push(PostPage(post: media)),
                    child: Container(
                      child: ImageNetwork(
                        src: (media.medias?.length ?? 0) > 0
                            ? media.medias?.first.thumb ??
                                media.medias?.first.url
                            : '',
                      ),
                    ),
                  );
                },
                staggeredTileBuilder: (index) => StaggeredTile.count(
                  2,
                  (index.isEven || index + 1 == medias.length) ? 3 : 2,
                ),
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
              ),
            ],
          );
        },
      ),
    );
  }
}
