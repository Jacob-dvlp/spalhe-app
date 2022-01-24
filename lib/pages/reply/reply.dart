import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:spalhe/components/comment_item/comment_item.dart';
import 'package:spalhe/controllers/posts/reply.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hashtagable/hashtagable.dart';

class ReplyPage extends StatelessWidget {
  final id, comment;
  const ReplyPage({Key? key, this.id, this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReplyController>(
      init: ReplyController(id),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Respostas'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CommentsComponent(
                      comment: comment,
                      reply: null,
                    ),
                  ),
                  Column(
                    children: List.generate(
                      _.replys.length,
                      (index) => CommentsComponent(
                        comment: _.replys[index],
                        reply: true,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight,
              ),
              child: SafeArea(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: HashTagTextField(
                          controller: _.textController,
                          decoration: const InputDecoration(
                            hintText: 'Responda esse comentário',
                            border: InputBorder.none,
                          ),
                          decoratedStyle: const TextStyle(
                            color: Colors.purple,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                          decorateAtSign: true,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(FeatherIcons.send),
                        onPressed: () => _.reply(),
                      )
                    ],
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
