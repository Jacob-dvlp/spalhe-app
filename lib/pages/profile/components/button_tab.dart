import 'package:flutter/material.dart';
import 'package:spalhe/theme/colors.dart';

class ButtonTabProfile extends StatelessWidget {
  const ButtonTabProfile({
    Key? key,
    required this.title,
    required this.onPress,
    required this.total,
    this.isActive = false,
  }) : super(key: key);

  final String title;
  final int total;
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
              horizontal: 16,
              vertical: 14,
            ).copyWith(bottom: 10),
            child: Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(width: 6),
                Container(
                  width: 20,
                  height: 20,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: primary.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    total.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
