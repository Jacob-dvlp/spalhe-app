import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:spalhe/components/form/input/input.dart';
import 'package:spalhe/components/layout/avatar/avatar.dart';
import 'package:spalhe/models/comments.model.dart';

class RepliesCommntPostPage extends StatelessWidget {
  const RepliesCommntPostPage({
    required this.comment,
  });

  final IComment comment;

  @override
  Widget build(BuildContext context) {
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
                          user: comment.user,
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
                                comment.user?.name ?? '',
                                style: TextStyle(),
                              ),
                              Opacity(
                                opacity: .6,
                                child: Text(
                                  '@${comment.user?.username}',
                                  style: TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              comment.cCount?.likes?.toString() ?? '',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(width: 5),
                            Icon(
                              FeatherIcons.heart,
                              size: 16,
                            ),
                            SizedBox(width: 20),
                            Text(
                              comment.cCount?.replies?.toString() ?? '',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(width: 5),
                            Icon(
                              FeatherIcons.messageSquare,
                              size: 16,
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 6),
                    Text(
                      comment.text ?? '',
                      style: TextStyle(
                        fontSize: 17,
                      ),
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
                              children: [
                                Avatar(
                                  user: comment.replies?[idx].user,
                                  width: 32,
                                  heigth: 32,
                                  iconSize: 8,
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      comment.replies?[idx].user?.name ?? '',
                                      style: TextStyle(),
                                    ),
                                    Opacity(
                                      opacity: .6,
                                      child: Text(
                                        '@${comment.replies?[idx].user?.username ?? ''}',
                                        style: TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 6),
                                    Text(
                                      comment.replies?[idx].text ?? '',
                                      style: TextStyle(),
                                    ),
                                  ],
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
                      // controller: _inputController,
                      // onChanged: (v) => _postItem.comment = v,
                      decoration: InputDecoration(
                        hintText: 'insira sua resposta',
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
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
