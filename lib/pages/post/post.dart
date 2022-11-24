import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:spalhe/components/form/input/input.dart';
import 'package:spalhe/components/layout/avatar/avatar.dart';
import 'package:spalhe/components/layout/list_view_wraper/list_view.dart';
import 'package:spalhe/components/layout/verified/verified.dart';
import 'package:spalhe/controllers/comments.controller.dart';
import 'package:spalhe/models/post.model.dart';
import 'package:spalhe/components/layout/post_item/post_item.dart';
import 'package:spalhe/pages/post/replies.post.dart';

class PostPage extends StatelessWidget {
  final _inputController = TextEditingController();
  PostPage({Key? key, required this.post}) : super(key: key) {
    final commentsController = Get.put(
      CommentsController(),
      tag: post.id.toString(),
    );
    commentsController.getComments(post.id);
  }

  final PostData post;

  @override
  Widget build(BuildContext context) {
    final commentsController = Get.put(
      CommentsController(),
      tag: post.id.toString(),
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          post.text ?? 'post'.tr,
          maxLines: 1,
        ),
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
                GetBuilder<CommentsController>(
                  tag: post.id.toString(),
                  builder: (_post) {
                    return Column(
                      children: List.generate(
                        _post.comments?.length ?? 0,
                        (index) {
                          final comment = _post.comments![index];
                          return GestureDetector(
                            onTap: () => Get.to(
                              () => RepliesCommntPostPage(
                                comment: comment,
                                postId: post.id,
                              ),
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                border: Border(
                                  top: BorderSide(
                                    color: Theme.of(context)
                                        .dividerColor
                                        .withOpacity(0.07),
                                  ),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Avatar(
                                        user: comment.user,
                                        width: 28,
                                        heigth: 28,
                                        iconSize: 8,
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Text(
                                              '${comment.user?.username}',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(width: 5),
                                            VerifiedComponent(
                                              user: comment.user!,
                                              iconSize: 14,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    comment.text ?? '',
                                    style: TextStyle(
                                      fontSize: 17,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          commentsController.toggleLike(
                                            comment.id,
                                            post.id,
                                          );
                                        },
                                        child: Icon(
                                          comment.isLiked == true
                                              ? Icons.favorite
                                              : FeatherIcons.heart,
                                          size: 16,
                                          color: comment.isLiked == true
                                              ? Colors.red
                                              : null,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        comment.cCount?.likes?.toString() ?? '',
                                        style: TextStyle(
                                          fontSize: 11,
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      GestureDetector(
                                        onTap: () => Get.to(
                                          () => RepliesCommntPostPage(
                                            comment: comment,
                                            postId: post.id,
                                          ),
                                        ),
                                        child: Icon(
                                          FeatherIcons.repeat,
                                          size: 16,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        comment.cCount?.replies?.toString() ??
                                            '',
                                        style: TextStyle(
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Column(
                                    children: [
                                      ...List.generate(
                                        comment.replies?.length ?? 0,
                                        (idx) => Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 10,
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Avatar(
                                                user:
                                                    comment.replies?[idx].user,
                                                width: 32,
                                                heigth: 32,
                                                iconSize: 8,
                                              ),
                                              SizedBox(width: 10),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          comment.replies?[idx]
                                                                  .user?.name ??
                                                              '',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                        SizedBox(width: 4),
                                                        VerifiedComponent(
                                                          user: comment
                                                              .replies![idx]
                                                              .user!,
                                                          iconSize: 14,
                                                        )
                                                      ],
                                                    ),
                                                    Text(
                                                      comment.replies?[idx]
                                                              .text ??
                                                          '',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      if ((comment.cCount?.replies ?? 0) > 3)
                                        TextButton(
                                          onPressed: () {
                                            Get.to(
                                              () => RepliesCommntPostPage(
                                                comment: comment,
                                                postId: post.id,
                                              ),
                                            );
                                          },
                                          child: Text(
                                            'ver todas as ${comment.cCount?.replies} respostas',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        )
                                    ],
                                  )
                                ],
                              ),
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
                      autofocus: false,
                      controller: _inputController,
                      onChanged: (v) => commentsController.comment = v,
                      decoration: InputDecoration(
                        hintText: 'enter_your_comment'.tr,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      commentsController.commentPost(post.id);
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
