import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class PlayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        elevation: 1,
        title: Text('play'),
        actions: [
          IconButton(
            icon: Icon(FeatherIcons.plusSquare),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
