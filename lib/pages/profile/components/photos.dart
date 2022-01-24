import 'package:spalhe/pages/post/post.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class GridImages extends StatelessWidget {
  final photos;
  GridImages(this.photos);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      crossAxisCount: 3,
      crossAxisSpacing: 3,
      mainAxisSpacing: 3,
      padding: EdgeInsets.all(3),
      children: List.generate(photos == null ? 0 : photos.length, (index) {
        return InkWell(
          onTap: () => Get.to(PostPage(photos[index]['id'])),
          child: photos[index]['files'][0]['type'] == 'video'
              ? Container(
                  color: Colors.grey.withOpacity(0.3),
                  child: Icon(Icons.video_library),
                )
              : CachedNetworkImage(
                  imageUrl: photos[index]['files'][0]['url'],
                  fit: BoxFit.cover,
                ),
        );
      }),
    );
  }
}
