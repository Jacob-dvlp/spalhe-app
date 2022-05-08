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
              border: isActive
                  ? Border(
                      bottom: BorderSide(
                        color: primary,
                        width: 4,
                        style: BorderStyle.solid,
                      ),
                    )
                  : null,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 14,
            ),
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
