import 'package:flutter/material.dart';
import 'package:spalhe/components/layout/loading/loading.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.title,
    required this.onPressed,
    this.icon,
    this.loading,
  }) : super(key: key);

  final String title;
  final void Function() onPressed;
  final IconData? icon;
  final bool? loading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Size.infinite.width,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
        ),
        onPressed: onPressed,
        child: loading == true
            ? Loading()
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null)
                    Row(
                      children: [Icon(icon), SizedBox(width: 10)],
                    ),
                  Text(title),
                ],
              ),
      ),
    );
  }
}
