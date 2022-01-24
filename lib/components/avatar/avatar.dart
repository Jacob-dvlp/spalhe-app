import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final double? width, height, border;
  final String url;

  const Avatar({
    Key? key,
    this.height,
    required this.url,
    this.width,
    this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).primaryColorDark.withOpacity(0.3);
    final light = Theme.of(context).primaryColorLight.withOpacity(0.8);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(border ?? 100),
        border: Border.all(width: 2, color: dark),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(border ?? 100),
          border: Border.all(width: 1.5, color: light),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(border ?? 100),
          child: CachedNetworkImage(
            imageUrl: url,
            fit: BoxFit.cover,
            width: width,
            height: height,
            errorWidget: (context, url, error) => CachedNetworkImage(
              imageUrl:
                  'https://www.globemoving.com/wp-content/uploads/2015/08/user.jpg',
            ),
          ),
        ),
      ),
    );
  }
}
