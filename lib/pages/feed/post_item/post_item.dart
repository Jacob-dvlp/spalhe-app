import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:hashtagable/hashtagable.dart';
import 'package:spalhe/components/layout/avatar/avatar.dart';
import 'package:spalhe/components/layout/image/image.dart';
import 'package:spalhe/controllers/post_item.controller.dart';
import 'package:spalhe/models/auth.dart';
import 'package:spalhe/models/post.model.dart';
import 'package:spalhe/pages/post/post.dart';
import 'package:spalhe/theme/colors.dart';
import 'package:spalhe/utils/routes.dart';

class PostItem extends StatelessWidget {
  PostItem({Key? key, this.post, this.inPostItem = false}) : super(key: key);

  final PostData? post;
  final bool inPostItem;

  final _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostItemController>(
      init: PostItemController(post: post!),
      tag: post?.id.toString() ?? '',
      builder: (_post) {
        final post = _post.post;
        final user = _post.post.user;
        final medias = _post.post.medias;

        final isLiked = post.likes!.isNotEmpty &&
            post.likes?.firstWhere((el) => el.userId == user?.id).userId !=
                null;

        return GestureDetector(
          onTap: () => inPostItem ? null : OnRoute.push(PostPage(post: post)),
          child: Container(
            padding: EdgeInsets.all(20).copyWith(bottom: 8),
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Avatar(
                      user: user as UserModel,
                      width: 38,
                      heigth: 38,
                      iconSize: 10,
                    ),
                    SizedBox(width: 14),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(user.name?.split(' ').first ?? ''),
                                    if (post.location != null)
                                      Flexible(
                                        child: Text(
                                          '  •  ${post.location?.name}',
                                          style: TextStyle(
                                            color: Colors.grey.shade500,
                                            fontSize: 12,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                  ],
                                ),
                                Text(
                                  '@${user.username}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 30),
                          Text(
                            '12:23',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HashTagText(
                      text: post.text ?? '',
                      decorateAtSign: true,
                      basicStyle: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      decoratedStyle: TextStyle(
                        color: primary,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 6),
                    if ((medias?.length ?? 0) > 0)
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width,
                        child: PageView(
                          controller: _pageController,
                          scrollDirection: Axis.horizontal,
                          scrollBehavior: ScrollBehavior(),
                          children: List.generate(
                            medias?.length ?? 0,
                            (index) => ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: ImageNetwork(
                                src: medias?[index].url,
                                width: Size.infinite.width,
                                height: 300,
                              ),
                            ),
                          ),
                        ),
                      )
                  ],
                ),
                SizedBox(height: 8),
                if ((post.cCount?.comments ?? 0) > 0)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Opacity(
                        opacity: 0.5,
                        child: Text(
                          'Ver todos os ${post.cCount?.comments} comentários',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            _post.likePost(user.id!);
                          },
                          icon: Icon(isLiked
                              ? Icons.favorite
                              : Icons.favorite_border_outlined),
                          iconSize: 24,
                          color: isLiked ? Colors.red : Colors.black87,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(FeatherIcons.messageCircle),
                          iconSize: 24,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(FeatherIcons.send),
                          iconSize: 24,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                      width: 80,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ...List.generate(
                            3,
                            (index) => Positioned(
                              right: 22 + (index * 14.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                padding: EdgeInsets.all(2),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: ImageNetwork(
                                    src: '',
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(3),
                              child: Text(
                                '+10',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
