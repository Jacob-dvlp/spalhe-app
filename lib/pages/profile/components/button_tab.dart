import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spalhe/theme/colors.dart';
import 'package:spalhe/utils/numbers.dart';

class ButtonTabProfile extends StatelessWidget {
  const ButtonTabProfile({
    Key? key,
    required this.icon,
    required this.onPress,
    required this.total,
    this.isActive = false,
  }) : super(key: key);

  final IconData icon;
  final int total;
  final Function onPress;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () => onPress(),
        child: Container(
          alignment: Alignment.center,
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  color: isActive
                      ? Get.theme.primaryColorDark
                      : Get.theme.primaryColorDark.withOpacity(0.3)),
              SizedBox(width: 5),
              if (total > 0)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isActive
                        ? primary
                        : Get.theme.primaryColorDark.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    formatToNumberString(total),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
