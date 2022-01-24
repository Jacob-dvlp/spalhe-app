import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AvatarGradient extends StatelessWidget {
  final url;
  final width;
  final height;
  final view;
  AvatarGradient(this.url, this.width, this.height, this.view);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(200),
        gradient: LinearGradient(
          colors: [
            Color(0xff009688),
            Colors.greenAccent,
          ],
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(200),
          color: Theme.of(context).primaryColorLight,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(200),
          child: Container(
            child: CachedNetworkImage(
              imageUrl: url,
              width: width,
              height: height,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
