import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:spalhe/components/layout/image/image.dart';
import 'package:spalhe/controllers/explore.controller.dart';

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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Novidades',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 14),
            Container(
              child: StaggeredGrid.count(
                crossAxisCount: 4,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                children: List.generate(
                  medias.length,
                  (index) => StaggeredGridTile.count(
                    crossAxisCellCount: (index / 2) == 0 ? 4 : 2,
                    mainAxisCellCount: (index / 2) == 0 ? 2 : 2,
                    child: Container(
                      child: ImageNetwork(src: medias[index].medias?[0].url),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
