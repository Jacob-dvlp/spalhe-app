import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Errors extends StatelessWidget {
  const Errors({
    Key? key,
    required this.icon,
    required this.description,
    required this.title,
  }) : super(key: key);

  final String icon, title, description;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/svg/$icon.svg',
          width: 200,
          height: 200,
        ),
        const SizedBox(height: 40),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(
            color: Theme.of(context).primaryColorDark.withOpacity(0.6),
          ),
        ),
      ],
    );
  }
}
