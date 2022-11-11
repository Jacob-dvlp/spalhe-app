import 'package:flutter/material.dart';

class ListViewWraper extends StatelessWidget {
  ListViewWraper({
    Key? key,
    required this.children,
    this.onRefresh = null,
    this.padding = const EdgeInsets.all(0),
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.controller,
    this.shrinkWrap = false,
  }) : super(key: key);

  final EdgeInsets padding;
  final List<Widget> children;
  final onRefresh;
  final Axis scrollDirection;
  final bool reverse;
  final ScrollController? controller;
  final bool shrinkWrap;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh ?? () async {},
      child: SingleChildScrollView(
        controller: controller,
        reverse: reverse,
        scrollDirection: scrollDirection,
        physics: BouncingScrollPhysics(),
        padding: padding,
        child: scrollDirection == Axis.horizontal
            ? Row(
                children: children,
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              ),
      ),
    );
  }
}
