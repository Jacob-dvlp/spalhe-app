import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final Color? color;
  final EdgeInsets? padding;
  const Loading({Key? key, this.color, this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.all(10),
      child: SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            color ?? Colors.white,
          ),
          strokeWidth: 2,
        ),
      ),
    );
  }
}
