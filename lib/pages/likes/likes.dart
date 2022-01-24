import 'package:spalhe/components/avatar/avatar.dart';
import 'package:spalhe/controllers/likes/like_controller.dart';
import 'package:spalhe/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LikesPage extends StatelessWidget {
  final post;
  const LikesPage({Key? key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Curtidas'),
        centerTitle: true,
      ),
      body: GetBuilder<LikeController>(
        init: LikeController(id: post['id']),
        builder: (_) => ListView(
          children: List.generate(_.likes.length, (index) {
            final like = _.likes[index];
            return InkWell(
              onTap: () => Utils.routeUser(like['user']),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Row(
                  children: [
                    Avatar(
                      url: like['user']['avatar'],
                      width: 42.0,
                      height: 42.0,
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(like['user']['name']),
                        Text(
                          '@${like['user']['username']}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context)
                                .primaryColorDark
                                .withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
