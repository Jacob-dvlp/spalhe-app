import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:spalhe/components/avatar/avatar.dart';
import 'package:spalhe/controllers/auth/auth.dart';
import 'package:spalhe/controllers/posts/onepost.dart';
import 'package:spalhe/pages/likes/likes.dart';
import 'package:spalhe/pages/post/post.dart';
import 'package:spalhe/pages/posts/components/video.dart';
import 'package:spalhe/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:hashtagable/hashtagable.dart';

class PostItem extends StatelessWidget {
  final Map post;
  final String? type;
  PostItem({Key? key, required this.post, this.type}) : super(key: key);

  final AuthController authController = Get.put(AuthController());

  void showBottomSheet(context, _) {
    Get.bottomSheet(Container(
      color: Theme.of(context).primaryColorLight,
      child: SafeArea(
        child: Material(
          color: Theme.of(context).primaryColorLight,
          child: Wrap(
            children: <Widget>[
              InkWell(
                onTap: () => _.deletePost(post['id']),
                child: const ListTile(
                  leading: Icon(FeatherIcons.trash),
                  title: Text('Apagar'),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final postUser =
        post['share_post'] != null ? post['share_post']['post'] : post;

    return GetBuilder<OnePostController>(
      init: OnePostController(post: post),
      tag: post['id'].toString(),
      builder: (_) => Container(
        margin: const EdgeInsets.symmetric(vertical: 2),
        child: !_.deleted
            ? Material(
                color: Theme.of(context).primaryColorLight,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: Column(
                    children: <Widget>[
                      //USER COLUMN
                      if (post['share_post'] != null)
                        Column(
                          children: [
                            InkWell(
                              onTap: () => Utils.routeUser(post['user']),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    ClipOval(
                                      child: Image.network(
                                        post['user']['avatar'],
                                        fit: BoxFit.cover,
                                        width: 20,
                                        height: 20,
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: [
                                              Text(
                                                post['user']['name'],
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                " repostou isso",
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: Theme.of(context)
                                                      .primaryColorDark
                                                      .withOpacity(0.5),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                InkWell(
                                  onTap: () => Utils.routeUser(post['user']),
                                  child: Row(
                                    children: [
                                      ClipOval(
                                        child: Avatar(
                                          url: post['share_user']['avatar'],
                                          width: 30.0,
                                          height: 30.0,
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              post['share_user']['name'],
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              "@" +
                                                  post['share_user']
                                                      ['username'],
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Theme.of(context)
                                                    .primaryColorDark
                                                    .withOpacity(0.8),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (post['user_id'] ==
                                    authController.auth['user']['id'])
                                  IconButton(
                                    onPressed: () =>
                                        showBottomSheet(context, _),
                                    icon: const Icon(
                                      FeatherIcons.moreHorizontal,
                                      size: 20,
                                    ),
                                  )
                              ],
                            ),
                          ],
                        )
                      else
                        InkWell(
                          onTap: () => Utils.routeUser(post['user']),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  ClipOval(
                                    child: Avatar(
                                      url: postUser['user']['avatar'],
                                      width: 30,
                                      height: 30,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          post['user']['name'],
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "@" + post['user']['username'],
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: Theme.of(context)
                                                    .primaryColorDark
                                                    .withOpacity(0.7),
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              '•',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Theme.of(context)
                                                    .primaryColorDark
                                                    .withOpacity(0.7),
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              Utils.date(post['created_at']),
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Theme.of(context)
                                                    .primaryColorDark
                                                    .withOpacity(0.7),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              if (post['user_id'] ==
                                  authController.auth['user']['id'])
                                IconButton(
                                  onPressed: () => showBottomSheet(context, _),
                                  icon: const Icon(
                                    FeatherIcons.moreHorizontal,
                                    size: 20,
                                  ),
                                )
                            ],
                          ),
                        ),
                      if (postUser['text'].length > 0)
                        Container(
                          alignment: Alignment.bottomLeft,
                          padding: const EdgeInsets.all(10),
                          child: HashTagText(
                            decorateAtSign: true,
                            text: postUser['text'].toString(),
                            basicStyle: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            decoratedStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff009688),
                            ),
                          ),
                        )
                      else
                        const SizedBox(height: 14),
                      if (postUser['files'].length > 0)
                        GestureDetector(
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              CarouselSlider(
                                items: (postUser['files'] as List).map((item) {
                                  if (item['type'] == 'video') {
                                    return VideoApp(item['file']);
                                  } else {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(16.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .primaryColorDark
                                              .withOpacity(0.1),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl: item['url'],
                                          fit: BoxFit.cover,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          placeholder: (context, url) =>
                                              const Center(
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                }).toList(),
                                options: CarouselOptions(
                                  aspectRatio: 1,
                                  pageSnapping: true,
                                  enlargeCenterPage: true,
                                  initialPage: _.currentSlide,
                                  viewportFraction:
                                      postUser['files'].length > 1 ? 0.94 : 1,
                                  autoPlay: false,
                                  enableInfiniteScroll: false,
                                  onPageChanged: (a, b) => _.addCurrentSlide(a),
                                ),
                              ),
                            ],
                          ),
                          onDoubleTap: () => _.likePost(post['id']),
                        ),
                      if (postUser['files'].length > 1)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(postUser['files'].length,
                                  (index) {
                                return AnimatedContainer(
                                  height: 8,
                                  width: _.currentSlide == index ? 18 : 8,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 3),
                                  decoration: BoxDecoration(
                                    color: _.currentSlide == index
                                        ? const Color(0xff00b894)
                                        : Theme.of(context)
                                            .primaryColorDark
                                            .withOpacity(0.25),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  duration: const Duration(milliseconds: 300),
                                );
                              })),
                        ),
                      Row(
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                icon: _.post['liked'] != null
                                    ? const Icon(Icons.favorite)
                                    : const Icon(Icons.favorite_border),
                                iconSize: 22,
                                color: _.post['liked'] != null
                                    ? Colors.red
                                    : Theme.of(context).primaryColorDark,
                                onPressed: () => _.likePost(_.post['id']),
                              ),
                              InkWell(
                                onTap: () => Get.to(LikesPage(
                                  post: _.post,
                                )),
                                child: Text(
                                  "${_.post['__meta__']['likes_count']}",
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(width: 30),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                icon: const Icon(FeatherIcons.messageCircle),
                                onPressed: () => Get.to(PostPage(post['id'])),
                                iconSize: 21,
                              ),
                              Text(
                                "${post['__meta__']['comments_count']}",
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(width: 30),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                icon: const Icon(FeatherIcons.share),
                                onPressed: () => _.sharePost(post['id']),
                                iconSize: 20,
                              ),
                              Text(
                                "${post['__meta__']['share_count']}",
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            : Container(),
      ),
    );
  }
}
