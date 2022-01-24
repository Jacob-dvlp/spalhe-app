import 'dart:io';

import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:spalhe/components/avatar/avatar.dart';
import 'package:spalhe/controllers/auth/auth.dart';
import 'package:spalhe/controllers/posts/posts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hashtagable/hashtagable.dart';
import 'package:spalhe/theme/colors.dart';

class NewPostPage extends StatelessWidget {
  NewPostPage({Key? key}) : super(key: key);
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final user = authController.auth['user'];
    return GetBuilder<PostsController>(
      init: PostsController(),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Nova publicação'),
          actions: [
            IconButton(
              icon: const Icon(FeatherIcons.check),
              onPressed: _.loading ? null : _.post,
            )
          ],
        ),
        backgroundColor: Theme.of(context).primaryColorLight,
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Row(
              children: <Widget>[
                Avatar(
                  url: user['avatar'],
                  width: 35,
                  height: 35,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Publicando como',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      user['name'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                )
              ],
            ),
            HashTagTextField(
              controller: _.textController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'No que você está pensado?',
                border: InputBorder.none,
                filled: false,
              ),
              decoratedStyle: const TextStyle(
                color: primary,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
              basicStyle: const TextStyle(fontSize: 20),
              decorateAtSign: true,
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(FeatherIcons.image),
                  onPressed: _.getImageFile,
                ),
                IconButton(
                  icon: const Icon(FeatherIcons.film),
                  onPressed: _.getVideoFile,
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 190,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(
                  _.images.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Stack(
                      children: [
                        if (_.images.isEmpty == false)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: _.images[index]['type'] == 'image'
                                ? Image.file(
                                    File(_.images[index]['path']),
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    width: 100,
                                    height: 100,
                                    color: Colors.teal,
                                    child: Icon(
                                      Icons.play_arrow_outlined,
                                      size: 33,
                                      color: Colors.white.withOpacity(0.4),
                                    ),
                                  ),
                          ),
                        Positioned(
                          right: 0,
                          child: IconButton(
                            onPressed: () => _.removeImage(index),
                            icon: const Icon(FeatherIcons.trash),
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
