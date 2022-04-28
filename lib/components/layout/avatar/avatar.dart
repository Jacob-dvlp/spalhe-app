import 'package:flutter/material.dart';
import 'package:spalhe/components/layout/image/image.dart';
import 'package:spalhe/models/auth.dart';

class Avatar extends StatelessWidget {
  final UserModel? user;
  final double width;
  final double heigth;
  final bool showIcon;

  const Avatar({
    Key? key,
    this.user,
    this.heigth = 100,
    this.width = 100,
    this.showIcon = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.white,
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
        ),
        if (showIcon)
          Positioned(
            right: 8,
            bottom: 6,
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.blue,
              ),
              child: Icon(
                Icons.check,
                size: 20,
                color: Colors.white,
              ),
            ),
          )
      ],
    );
  }
}
