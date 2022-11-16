import 'package:flutter/material.dart';
import 'package:spalhe/components/layout/image/image.dart';
import 'package:spalhe/models/user.model.dart';

class Avatar extends StatelessWidget {
  final UserModel? user;
  final double width;
  final double heigth;
  final double iconSize;
  final bool? showIcon;

  const Avatar({
    Key? key,
    this.user,
    this.heigth = 100,
    this.width = 100,
    this.iconSize = 30,
    this.showIcon = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(heigth > 100 ? 4 : 0),
      decoration: BoxDecoration(
        color: heigth > 100 ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(100),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: ImageNetwork(
          src: user?.avatar,
          width: width,
          height: heigth,
        ),
      ),
    );
  }
}
