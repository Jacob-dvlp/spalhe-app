import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spalhe/models/user.model.dart';

class VerifiedComponent extends StatelessWidget {
  VerifiedComponent({required this.user, this.iconSize = 20});

  final UserModel user;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    if (user.verified == true)
      return Container(
        child: SvgPicture.asset(
          'assets/svg/veirified.svg',
          width: iconSize,
          height: iconSize,
        ),
      );

    return Container();
  }
}
