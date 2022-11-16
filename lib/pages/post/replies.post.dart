import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:spalhe/components/form/input/input.dart';
import 'package:spalhe/components/layout/avatar/avatar.dart';
import 'package:spalhe/components/layout/verified/verified.dart';
import 'package:spalhe/controllers/comments.controller.dart';
import 'package:spalhe/models/comments.model.dart';

class RepliesCommntPostPage extends StatelessWidget {
  RepliesCommntPostPage({
    required this.comment,
    this.postId,
  }) {
    final commentsController = Get.put(
      CommentsController(),
      tag: postId.toString(),
    );
    commentsController.getRepliesComments(comment.id);
  }

  final int? postId;
  final IComment comment;

  @override
  Widget build(BuildContext context) {
    final _inputController = TextEditingController();

    return GetBuilder<CommentsController>(
      init: CommentsController(),
      tag: postId.toString(),
      builder: (controller) {
        final replies = controller.replies;
        final IComment? comment =
            controller.comments?.firstWhere((el) => el.id == this.comment.id);

        return Scaffold(
          appBar: AppBar(
            title: Text('Respostas'),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(24),
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Avatar(
                              user: comment?.user,
                              width: 32,
                              heigth: 32,
                              iconSize: 8,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    comment?.user?.name ?? '',
                                    style: TextStyle(),
                                  ),
                                  Opacity(
                                    opacity: .6,
                                    child: Text(
                                      '@${comment?.user?.username}',
                                      style: TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6),
                        Text(
                          comment?.text ?? '',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                controller.toggleLike(
                                  comment?.id,
                                  postId,
                                );
                              },
                              icon: Icon(
                                comment?.isLiked == true
                                    ? Icons.favorite
                                    : FeatherIcons.heart,
                                size: 16,
                                color: comment?.isLiked == true
                                    ? Colors.red
                                    : null,
                              ),
                            ),
                            Text(
                              comment?.cCount?.likes?.toString() ?? '',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(width: 20),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                FeatherIcons.repeat,
                                size: 16,
                              ),
                            ),
                            Text(
                              comment?.cCount?.replies?.toString() ?? '',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Column(
                          children: [
                            ...List.generate(
                              replies?.length ?? 0,
                              (idx) => Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Avatar(
                                      user: replies?[idx].user,
                                      width: 32,
                                      heigth: 32,
                                      showIcon: false,
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
                                                replies?[idx].user?.name ?? '',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(width: 4),
                                              VerifiedComponent(
                                                user: replies![idx].user!,
                                                iconSize: 14,
                                              )
                                            ],
                                          ),
                                          Text(
                                            replies[idx].text ?? '',
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
                          ],
                        )
                      ],
                    ),
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
                          onChanged: (v) => controller.replyCommentText = v,
                          decoration: InputDecoration(
                            hintText: 'insira sua resposta',
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          controller.replyComment(comment?.id, postId);
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
      },
    );
  }
}
