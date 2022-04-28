import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:hashtagable/hashtagable.dart';
import 'package:spalhe/controllers/posts.controller.dart';
import 'package:spalhe/theme/colors.dart';
import 'package:spalhe/utils/routes.dart';

class NewPostPage extends StatelessWidget {
  const NewPostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostController>(
      init: PostController(),
      builder: (_post) {
        return WillPopScope(
          onWillPop: () async {
            bool returnValue = true;
            if (_post.images.isNotEmpty) {
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
                        child: const Text(
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
                        child: const Text(
                          'Descartar',
                          style: TextStyle(
                            color: Colors.black87,
                          ),
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
            backgroundColor: Colors.white,
            body: ListView(
              padding: EdgeInsets.all(0),
              children: [
                Form(
                  child: Column(
                    children: [
                      HashTagTextField(
                        decorateAtSign: true,
                        basicStyle: TextStyle(
                          fontSize: 16,
                        ),
                        decoratedStyle: TextStyle(
                          color: primary,
                          fontSize: 16,
                        ),
                        maxLines: 6,
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
                                  child: Image.asset(_post.images[index].path),
                                ),
                              ),
                            )
                          ].toList(),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () => _post.addImages(),
                                icon: Icon(
                                  FeatherIcons.image,
                                ),
                              ),
                              IconButton(
                                onPressed: () => _post.addVideos(),
                                icon: Icon(
                                  Icons.video_collection_outlined,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  FeatherIcons.mapPin,
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 14),
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text('postar'),
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
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
