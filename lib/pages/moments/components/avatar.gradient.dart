import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AvatarGradient extends StatelessWidget {
  final url;
  final width;
  final height;
  final view;

  const AvatarGradient(
    this.url,
    this.width,
    this.height,
    this.view, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(200),
        gradient: const LinearGradient(
          colors: [
            Color(0xff009688),
            Colors.greenAccent,
          ],
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(200),
          color: Theme.of(context).primaryColorLight,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(200),
          child: CachedNetworkImage(
            imageUrl: url,
            width: width,
            height: height,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
