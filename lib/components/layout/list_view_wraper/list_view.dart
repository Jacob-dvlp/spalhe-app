import 'package:flutter/material.dart';

class ListViewWraper extends StatelessWidget {
  ListViewWraper({
    Key? key,
    required this.children,
    this.onRefresh = null,
    this.padding = const EdgeInsets.all(0),
  }) : super(key: key);

  final EdgeInsets padding;
  final List<Widget> children;
  final onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh ?? () async {},
      child: ListView(
        padding: padding,
        children: children,
      ),
    );
  }
}
