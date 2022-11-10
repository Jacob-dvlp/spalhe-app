import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageNetwork extends StatelessWidget {
  const ImageNetwork({
    Key? key,
    required this.src,
    this.height = 100,
    this.width = 100,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  final String? src;
  final double width, height;
  final BoxFit fit;
  final noImage = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(4),
      ),
      child: src == null || src == ''
          ? Container()
          : CachedNetworkImage(
              cacheKey: src,
              imageUrl: (src != null && src != '') ? src! : noImage,
              fit: fit,
              errorWidget: (ctx, err, _) => Container(),
            ),
    );
  }
}
