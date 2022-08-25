import 'package:flutter/material.dart';

class ListViewWraper extends StatelessWidget {
  const ListViewWraper({
    Key? key,
    required this.children,
    this.padding = const EdgeInsets.all(0),
  }) : super(key: key);

  final EdgeInsets padding;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: padding,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }
}
