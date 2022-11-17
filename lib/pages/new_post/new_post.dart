import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:hashtagable/hashtagable.dart';
import 'package:spalhe/components/layout/image/image.dart';
import 'package:spalhe/components/layout/list_view_wraper/list_view.dart';
import 'package:spalhe/components/layout/loading/loading.dart';
import 'package:spalhe/components/layout/post_item/post_item.dart';
import 'package:spalhe/controllers/posts.controller.dart';
import 'package:spalhe/models/post.model.dart';
import 'package:spalhe/pages/new_post/location.dart';
import 'package:spalhe/theme/colors.dart';
import 'package:spalhe/utils/routes.dart';

class NewPostPage extends StatelessWidget {
  const NewPostPage({Key? key, this.post}) : super(key: key);

  final PostData? post;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostController>(
      init: PostController(),
      builder: (_post) {
        final postData = _post.postData;

        return WillPopScope(
          onWillPop: () async {
            bool returnValue = true;
            if (_post.images.isNotEmpty ||
                _post.videos.isNotEmpty ||
                postData['location'] != null ||
                postData['text'] != null) {
              await showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    title: Text('Descartar alterações'),
                    content: Text(
                      'Ao sair, você estará descartando essa publicação',
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          returnValue = false;
                          OnRoute.back();
                        },
                        child: Text(
                          'Cancelar',
                          style: TextStyle(
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          returnValue = true;
                          _post.clearPost();
                          OnRoute.back();
                        },
                        child: Text(
                          'Descartar',
                          style: TextStyle(),
                        ),
                      ),
                    ],
                  );
                },
              );
            }
            return returnValue;
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text('nova publicação'),
            ),
            body: ListViewWraper(
              padding: EdgeInsets.all(0),
              children: [
                Form(
                  child: Column(
                    children: [
                      HashTagTextField(
                        onChanged: (value) => _post.setData('text', value),
                        decorateAtSign: true,
                        basicStyle: TextStyle(
                          fontSize: 16,
                        ),
                        decoratedStyle: TextStyle(
                          color: primary,
                          fontSize: 16,
                        ),
                        maxLines: 14,
                        decoration: InputDecoration(
                          hintText: 'o que você quer espalhar?',
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                      if (_post.images.isNotEmpty)
                        Row(
                          children: [
                            ...List.generate(
                              _post.images.length,
                              (index) => Container(
                                margin: EdgeInsets.symmetric(horizontal: 8)
                                    .copyWith(right: 0),
                                width: 80,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.file(
                                    File(_post.images[index].path),
                                  ),
                                ),
                              ),
                            )
                          ].toList(),
                        ),
                      if (_post.videos.isNotEmpty)
                        Row(
                          children: [
                            ...List.generate(
                              _post.videos.length,
                              (index) => Container(
                                margin: EdgeInsets.symmetric(horizontal: 8)
                                    .copyWith(right: 0),
                                width: 80,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: ImageNetwork(
                                    src:
                                        'https://lisdermoplastica.com.br/wp-content/uploads/2017/08/video-placeholder.jpg',
                                  ),
                                ),
                              ),
                            )
                          ].toList(),
                        ),
                      SizedBox(height: 10),
                      if (_post.postData['location']?['name'] != null)
                        Column(
                          children: [
                            Divider(),
                            Container(
                              width: Size.infinite.width,
                              padding: EdgeInsets.symmetric(horizontal: 14),
                              decoration: BoxDecoration(),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      _post.postData['location']['name'],
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  IconButton(
                                    onPressed: () => _post.clearLocation(),
                                    icon: Icon(FeatherIcons.x),
                                  )
                                ],
                              ),
                            ),
                            Divider(),
                          ],
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              if (post == null)
                                IconButton(
                                  onPressed: () => _post.addImages(),
                                  icon: Icon(
                                    FeatherIcons.image,
                                  ),
                                ),
                              if (post == null)
                                IconButton(
                                  onPressed: () => _post.addVideos(),
                                  icon: Icon(
                                    Icons.video_collection_outlined,
                                  ),
                                ),
                              IconButton(
                                onPressed: () => OnRoute.push(LocationPage()),
                                icon: Icon(
                                  FeatherIcons.mapPin,
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 14),
                            child: ElevatedButton(
                              onPressed: _post.postLoading
                                  ? null
                                  : () {
                                      if (post?.id != null) {
                                        _post.postData['post_id'] = post?.id;
                                      }
                                      _post.createPost();
                                    },
                              child: _post.postLoading
                                  ? Loading()
                                  : Text('postar'),
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 40,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                if (post != null)
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: PostItem(
                          post: post,
                          showActions: false,
                          inPostItem: true,
                        ),
                      ),
                      SizedBox(height: 100),
                    ],
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}
