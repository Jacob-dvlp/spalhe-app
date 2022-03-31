import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:spalhe/components/layout/image/image.dart';
import 'package:spalhe/pages/feed/post_item/post_item.dart';
import 'package:spalhe/pages/new_storie/new_storie.dart';
import 'package:spalhe/utils/routes.dart';
import 'package:stories_editor/stories_editor.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 6,
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: ImageNetwork(
                src: '',
                width: 40,
                height: 40,
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Olá',
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  'Thiago',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(FeatherIcons.edit),
          ),
        ],
      ),
      body: ListView(
        children: [
          Row(
            children: [],
          ),
          Column(
            children: List.generate(
              10,
              (index) => PostItem(),
            ),
          )
        ],
      ),
    );
  }
}
