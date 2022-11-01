import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:spalhe/components/form/input/input.dart';
import 'package:spalhe/components/layout/avatar/avatar.dart';
import 'package:spalhe/components/layout/list_view_wraper/list_view.dart';
import 'package:spalhe/controllers/post_item.controller.dart';
import 'package:spalhe/models/post.model.dart';
import 'package:spalhe/components/layout/post_item/post_item.dart';

class PostPage extends StatelessWidget {
  final _inputController = TextEditingController();
  PostPage({Key? key, required this.post}) : super(key: key) {
    final _postItem = Get.put(
      PostItemController(
        post: post,
      ),
      tag: post.id.toString(),
    );
    _postItem.getComments();
  }

  final PostData post;

  @override
  Widget build(BuildContext context) {
    final _postItem = Get.put(
      PostItemController(
        post: post,
      ),
      tag: post.id.toString(),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(post.text ?? 'Publicação'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListViewWraper(
              children: [
                PostItem(
                  post: post,
                  inPostItem: true,
                ),
                GetBuilder<PostItemController>(
                  tag: post.id.toString(),
                  builder: (_post) {
                    return Column(
                      children: List.generate(
                        _post.comments?.data.length ?? 0,
                        (index) {
                          final comment = _post.comments!.data[index];
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            margin: EdgeInsets.only(bottom: 1.2),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Avatar(
                                      user: comment.user,
                                      width: 32,
                                      heigth: 32,
                                      iconSize: 8,
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          comment.user.name ?? '',
                                          style: TextStyle(),
                                        ),
                                        Opacity(
                                          opacity: .6,
                                          child: Text(
                                            '@${comment.user.username}',
                                            style: TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Text(
                                  comment.text,
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: Border(
                top: BorderSide(
                  width: 1,
                  color: Colors.grey.withOpacity(.2),
                ),
              ),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Flexible(
                    child: Input(
                      controller: _inputController,
                      onChanged: (v) => _postItem.comment = v,
                      decoration: InputDecoration(
                        hintText: 'Insira seu comentário',
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _postItem.commentPost();
                      _inputController.clear();
                    },
                    icon: Icon(FeatherIcons.send),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
