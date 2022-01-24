import 'package:spalhe/components/avatar/avatar.dart';
import 'package:spalhe/pages/reply/reply.dart';
import 'package:spalhe/services/api.dart';
import 'package:spalhe/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hashtagable/hashtagable.dart';

class CommentsComponent extends StatelessWidget {
  final comment, reply;
  const CommentsComponent(
      {Key? key, required this.comment, required this.reply})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UnicCommentController>(
      init: UnicCommentController(comment),
      tag: comment['id'].toString(),
      builder: (_) => Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Avatar(
                    url: comment['user']['avatar'],
                    width: 25.0,
                    height: 25.0,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: [
                              Text(
                                comment['user']['name']
                                    .toString()
                                    .split(' ')[0],
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(
                                  comment['user']['username'],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            Utils.date(comment['created_at']),
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[600],
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: HashTagText(
                          decorateAtSign: true,
                          text: "${comment['text'] ?? ''}",
                          basicStyle: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          decoratedStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.purple,
                            fontWeight: FontWeight.w500,
                          ),
                          onTap: (s) => print(s),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            reply == null
                ? Row(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            padding: EdgeInsets.all(5),
                            icon: _.comment['liked'] != null
                                ? Icon(Icons.favorite)
                                : Icon(Icons.favorite_border),
                            color: _.comment['liked'] != null
                                ? Colors.red
                                : Theme.of(context).primaryColorDark,
                            iconSize: 18,
                            onPressed: () => _.likeComment(),
                          ),
                          Text(
                            _.comment['__meta__']['likes_count'].toString(),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            padding: EdgeInsets.all(5),
                            icon: Icon(
                              Icons.repeat,
                              size: 18,
                            ),
                            onPressed: () => Get.to(ReplyPage(
                              id: comment['id'],
                              comment: comment,
                            )),
                          ),
                          Text(
                            _.comment['__meta__']['reply_count'].toString(),
                          ),
                        ],
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

class UnicCommentController extends GetxController {
  var comment = {};
  UnicCommentController(this.comment);

  void likeComment() async {
    if (comment['liked'] == null) {
      comment['liked'] = true;
      comment['__meta__']['likes_count'] =
          comment['__meta__']['likes_count'] + 1;
    } else {
      comment['liked'] = null;
      comment['__meta__']['likes_count'] =
          comment['__meta__']['likes_count'] - 1;
    }
    update();
    var res = await API.post('/comments/${comment['id']}/like', {
      "post_id": comment['id'],
    });
    if (res.statusCode == 200) {
      print('curtiu');
    } else {
      print('não curtiu');
    }
  }
}
