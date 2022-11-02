import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:hashtagable/hashtagable.dart';
import 'package:spalhe/components/layout/avatar/avatar.dart';
import 'package:spalhe/components/layout/image/image.dart';
import 'package:spalhe/components/layout/post_item/components/showLikesInPostModal.dart';
import 'package:spalhe/controllers/post_item.controller.dart';
import 'package:spalhe/controllers/posts.controller.dart';
import 'package:spalhe/models/post.model.dart';
import 'package:spalhe/pages/new_post/new_post.dart';
import 'package:spalhe/pages/post/post.dart';
import 'package:spalhe/theme/colors.dart';
import 'package:spalhe/utils/date.dart';
import 'package:spalhe/utils/routes.dart';

class PostItem extends StatelessWidget {
  PostItem({
    Key? key,
    this.post,
    this.inPostItem = false,
    this.showActions = true,
  }) : super(key: key);

  final PostData? post;
  final bool inPostItem;
  final bool showActions;

  final _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    final postsController = Get.put(PostController());

    return GetBuilder<PostItemController>(
      global: true,
      autoRemove: false,
      init: new PostItemController(post: post!),
      tag: post!.id.toString(),
      assignId: true,
      builder: (_post) {
        final post = _post.post;
        final user = _post.post.user;
        final medias = _post.post.medias;
        final isLiked = post.isLiked == true;

        return GestureDetector(
          onTap: () => inPostItem ? null : OnRoute.push(PostPage(post: post)),
          child: Container(
            padding: EdgeInsets.all(16).copyWith(bottom: 6),
            margin: showActions ? EdgeInsets.only(bottom: 10) : null,
            color: Theme.of(context).cardColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Avatar(
                      user: user,
                      width: 38,
                      heigth: 38,
                      iconSize: 10,
                    ),
                    SizedBox(width: 8),
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
                                    Text(user?.name?.split(' ').first ?? ''),
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
                                  '@${user?.username}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 30),
                          Row(
                            children: [
                              Text(
                                fromNow(post.createdAt),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              if (showActions)
                                GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                      backgroundColor:
                                          Theme.of(context).cardColor,
                                      context: context,
                                      builder: (BuildContext bc) {
                                        return SafeArea(
                                          child: Wrap(
                                            children: [
                                              ListTile(
                                                tileColor:
                                                    Theme.of(context).cardColor,
                                                leading: Icon(
                                                  Icons.favorite_border,
                                                ),
                                                title: Text('quem gostou'),
                                                onTap: () async {
                                                  Get.back();
                                                  _post.getLikesInPost();
                                                  ShowLikesInPostModal(
                                                    post: post,
                                                    context: context,
                                                  );
                                                },
                                              ),
                                              ListTile(
                                                tileColor:
                                                    Theme.of(context).cardColor,
                                                leading: Icon(
                                                  Icons.bookmark_border_rounded,
                                                ),
                                                title: Text('salvar'),
                                                onTap: () => {},
                                              ),
                                              ListTile(
                                                tileColor:
                                                    Theme.of(context).cardColor,
                                                leading: Icon(
                                                  Icons.delete_outline_outlined,
                                                ),
                                                title: Text('excluir'),
                                                onTap: () => postsController
                                                    .deletePost(post.id!),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.more_vert_rounded,
                                    ),
                                  ),
                                )
                            ],
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
                    if (post.text != null && post.text != '')
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
                    if (post.repost != null)
                      Container(
                        margin: !(post.text != null && post.text != '')
                            ? null
                            : EdgeInsets.only(top: 16),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.6),
                            width: 0.5,
                          ),
                        ),
                        child: PostItem(
                          post: post.repost,
                          showActions: false,
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
                if (showActions) SizedBox(height: 16),
                if (showActions)
                  Opacity(
                    opacity: 0.7,
                    child: Row(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${post.cCount?.likes}',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 4),
                            Text(
                              (post.cCount?.likes ?? 0) > 1
                                  ? 'gosteis'
                                  : 'gostou',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                        SizedBox(width: 20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${post.cCount?.comments}',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 4),
                            Text(
                              (post.cCount?.comments ?? 0) > 1
                                  ? 'comentários'
                                  : 'comentário',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${post.cCount?.reposts ?? 0}',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 4),
                            Text(
                              (post.cCount?.reposts ?? 0) > 1
                                  ? 'spalharam'
                                  : 'spalhou',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                if (showActions) SizedBox(height: 16),
                if (showActions)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Row(
                          children: [
                            InkWell(
                              onTap: _post.likePost,
                              child: Icon(
                                isLiked
                                    ? Icons.favorite
                                    : Icons.favorite_border_outlined,
                                size: 24,
                                color: isLiked ? Colors.red : null,
                              ),
                            ),
                            SizedBox(width: 30),
                            InkWell(
                              onTap: () {},
                              child: Icon(
                                FeatherIcons.messageSquare,
                                size: 24,
                              ),
                            ),
                            SizedBox(width: 30),
                            InkWell(
                              onTap: () {
                                Get.to(
                                  () => NewPostPage(
                                    post: post.repost != null
                                        ? post.repost
                                        : post,
                                  ),
                                );
                              },
                              child: Icon(
                                FeatherIcons.repeat,
                                size: 24,
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: Icon(
                                      Icons.bookmark_border_rounded,
                                      size: 26,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                if (showActions) SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}
