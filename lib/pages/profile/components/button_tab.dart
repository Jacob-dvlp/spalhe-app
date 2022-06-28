import 'package:flutter/material.dart';
import 'package:spalhe/theme/colors.dart';

class ButtonTabProfile extends StatelessWidget {
  const ButtonTabProfile({
    Key? key,
    required this.title,
    required this.onPress,
    this.isActive = false,
  }) : super(key: key);

  final String title;
  final Function onPress;
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPress(),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: isActive ? primary : Colors.transparent,
                  width: isActive ? 4 : 4,
                  style: BorderStyle.solid,
                ),
              ),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 14,
            ).copyWith(bottom: 10),
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
