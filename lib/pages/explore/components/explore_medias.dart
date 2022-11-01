import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spalhe/controllers/explore.controller.dart';
import 'package:spalhe/components/layout/post_item/post_item.dart';

class ExploreMidias extends StatelessWidget {
  const ExploreMidias({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExploreController>(
      init: ExploreController(),
      builder: (exploreController) {
        final medias = exploreController.postMedias?.data ?? [];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Column(
              children: List.generate(
                medias.length,
                (index) => new PostItem(post: medias[index]),
              ),
            ),
          ],
        );
      },
    );
  }
}
