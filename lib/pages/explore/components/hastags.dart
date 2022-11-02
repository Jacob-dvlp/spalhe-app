import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spalhe/controllers/hashtags.controller.dart';
import 'package:spalhe/pages/explore/pages/hashtags_posts/hashtags_posts.dart';
import 'package:spalhe/theme/colors.dart';

class HashtagsWidget extends StatelessWidget {
  const HashtagsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'hashtags populares',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // TextButton(onPressed: () {}, child: Text('ver mais'))
            ],
          ),
        ),
        Divider(),
        SizedBox(
          height: 55,
          child: GetBuilder<HashtagsController>(
            init: HashtagsController(),
            builder: (context) {
              final hashs = context.hashtags.getHashtags ?? [];
              return ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(
                  hashs.length,
                  (index) => GestureDetector(
                    onTap: () => Get.to(
                      () => HashtagsPostsPage(hashtag: hashs[index].hashtag!),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '#${hashs[index].hashtag}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: primary,
                            ),
                          ),
                          Text(
                            '${hashs[index].cCount?.hashtagsOnPost} posts',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Divider(),
      ],
    );
  }
}
