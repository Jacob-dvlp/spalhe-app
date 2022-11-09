import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:hashtagable/hashtagable.dart';
import 'package:spalhe/components/layout/avatar/avatar.dart';
import 'package:spalhe/components/layout/image/image.dart';
import 'package:spalhe/components/layout/post_item/pages/likes.dart';
import 'package:spalhe/components/layout/video/video.dart';
import 'package:spalhe/constants/video_types.dart';
import 'package:spalhe/controllers/auth.controller.dart';
import 'package:spalhe/controllers/post_item.controller.dart';
import 'package:spalhe/models/post.model.dart';
import 'package:spalhe/pages/explore/pages/hashtags_posts/hashtags_posts.dart';
import 'package:spalhe/pages/new_post/new_post.dart';
import 'package:spalhe/pages/post/post.dart';
import 'package:spalhe/pages/profile/profile.dart';
import 'package:spalhe/pages/user/user.dart';
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
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final authuser = authController.auth.user;

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

        final deleted = _post.deleted == true;

        if (deleted) return Container();

        return Container(
          margin: showActions ? EdgeInsets.only(bottom: 10) : null,
          color: Theme.of(context).cardColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  if (authuser?.id == user?.id) {
                    OnRoute.push(ProfilePage());
                  } else {
                    OnRoute.push(UserPage(
                      userId: user!.id!,
                    ));
                  }
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ).copyWith(top: 20),
                  child: Row(
                    children: [
                      Avatar(
                        user: user,
                        width: 38,
                        heigth: 38,
                        iconSize: 17,
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
                                                  tileColor: Theme.of(context)
                                                      .cardColor,
                                                  leading: Icon(
                                                    post.isSaved == true
                                                        ? Icons.bookmark
                                                        : Icons
                                                            .bookmark_border_rounded,
                                                  ),
                                                  title: Text(
                                                      post.isSaved == true
                                                          ? 'remover dos salvos'
                                                          : 'salvar post'),
                                                  onTap: () {
                                                    _post.savePost();
                                                    Get.back();
                                                  },
                                                ),
                                                if (authuser?.id !=
                                                    post.user?.id)
                                                  ListTile(
                                                    tileColor: Theme.of(context)
                                                        .cardColor,
                                                    leading: Icon(
                                                      FeatherIcons
                                                          .alertTriangle,
                                                    ),
                                                    title:
                                                        Text('denunciar post'),
                                                    onTap: () => _post
                                                        .reportPost(post.id!),
                                                  ),
                                                if (authuser?.id ==
                                                    post.user?.id)
                                                  ListTile(
                                                    tileColor: Theme.of(context)
                                                        .cardColor,
                                                    leading: Icon(
                                                      Icons
                                                          .delete_outline_outlined,
                                                    ),
                                                    title: Text('excluir'),
                                                    onTap: () => _post
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
                ),
              ),
              SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (post.text != null && post.text != '')
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: HashTagText(
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
                        onTap: (text) {
                          if (text.startsWith('#')) {
                            final hash = text.substring(1);
                            OnRoute.push(HashtagsPostsPage(hashtag: hash));
                          } else {}
                        },
                      ),
                    ),
                  if (post.repost != null)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
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
                    ),
                  SizedBox(height: 14),
                  if ((medias?.length ?? 0) > 0)
                    GestureDetector(
                      onDoubleTap: () => _post.likePost(),
                      child: SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.width,
                        child: PageView(
                          controller: _pageController,
                          scrollDirection: Axis.horizontal,
                          scrollBehavior: ScrollBehavior(),
                          children: List.generate(
                            medias?.length ?? 0,
                            (index) {
                              final media = medias![index];
                              if (VideoTypes.contains(
                                  media.type?.toLowerCase())) {
                                return VideoPlayerComponent(
                                    videoUrl: media.url!);
                              } else
                                return ClipRRect(
                                  child: ImageNetwork(
                                    src: media.url,
                                    width: Size.infinite.width,
                                  ),
                                );
                            },
                          ),
                        ),
                      ),
                    )
                ],
              ),
              if (showActions) SizedBox(height: 16),
              if (showActions)
                InkWell(
                  onTap: () => OnRoute.push(LikesInPostPage(postId: post.id!)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Opacity(
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
                  ),
                ),
              if (showActions) SizedBox(height: 16),
              if (showActions)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: _post.likePost,
                              icon: Icon(
                                isLiked
                                    ? Icons.favorite
                                    : Icons.favorite_border_outlined,
                                size: 24,
                                color: isLiked ? Colors.red : null,
                              ),
                            ),
                            SizedBox(width: 16),
                            IconButton(
                              onPressed: () => inPostItem
                                  ? null
                                  : OnRoute.push(PostPage(post: post)),
                              icon: Icon(
                                FeatherIcons.messageSquare,
                                size: 22,
                              ),
                            ),
                            SizedBox(width: 16),
                            IconButton(
                              onPressed: () {
                                Get.to(
                                  () => NewPostPage(
                                    post: post.repost != null
                                        ? post.repost
                                        : post,
                                  ),
                                );
                              },
                              icon: Icon(
                                FeatherIcons.repeat,
                                size: 22,
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: _post.savePost,
                                    icon: Icon(
                                      post.isSaved == true
                                          ? Icons.bookmark
                                          : Icons.bookmark_border_rounded,
                                      size: 24,
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
                ),
              if (showActions) SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}
