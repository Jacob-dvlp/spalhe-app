import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hashtagable/hashtagable.dart';
import 'package:spalhe/components/layout/avatar/avatar.dart';
import 'package:spalhe/components/layout/image/image.dart';
import 'package:spalhe/components/layout/image_modal/image_modal.dart';
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
      global: false,
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
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            boxShadow: !showActions
                ? null
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  if (authuser?.id == user?.id) {
                    OnRoute.push(ProfilePage());
                  } else {
                    OnRoute.push(UserPage(userId: user!.id!));
                  }
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12,
                  ).copyWith(top: 12),
                  child: Row(
                    children: [
                      Avatar(
                        user: user,
                        width: 38,
                        heigth: 38,
                        showIcon: false,
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
                                      Row(
                                        children: [
                                          Text(user?.name?.split(' ').first ??
                                              ''),
                                          if (user?.verified == true)
                                            Row(
                                              children: [
                                                SizedBox(width: 5),
                                                Container(
                                                  child: SvgPicture.asset(
                                                    'assets/svg/veirified.svg',
                                                    width: 13,
                                                    height: 13,
                                                  ),
                                                ),
                                              ],
                                            )
                                        ],
                                      ),
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
                                  Row(
                                    children: [
                                      Text(
                                        '@${user?.username}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade500,
                                        ),
                                      ),
                                      Text(
                                        '  •  ${fromNow(post.createdAt)}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 30),
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
                                              leading: Icon(FeatherIcons.heart),
                                              title: Text('see_who_liked'.tr),
                                              onTap: () => OnRoute.push(
                                                  LikesInPostPage(
                                                      postId: post.id!)),
                                            ),
                                            ListTile(
                                              tileColor:
                                                  Theme.of(context).cardColor,
                                              leading: Icon(
                                                post.isSaved == true
                                                    ? Icons.bookmark
                                                    : Icons
                                                        .bookmark_border_rounded,
                                              ),
                                              title: Text(post.isSaved == true
                                                  ? 'remove_save_post'.tr
                                                  : 'save_post'.tr),
                                              onTap: () {
                                                _post.savePost();
                                                Get.back();
                                              },
                                            ),
                                            if (authuser?.id != post.user?.id)
                                              ListTile(
                                                tileColor:
                                                    Theme.of(context).cardColor,
                                                leading: Icon(
                                                  FeatherIcons.eyeOff,
                                                ),
                                                title: Text(
                                                    'see_less_posts_like_this'
                                                        .tr),
                                                onTap: () => _post.reportPost(
                                                    post.id!, true),
                                              ),
                                            if (authuser?.id != post.user?.id)
                                              ListTile(
                                                tileColor:
                                                    Theme.of(context).cardColor,
                                                leading: Icon(
                                                  FeatherIcons.alertTriangle,
                                                ),
                                                title: Text('report_post'.tr),
                                                onTap: () =>
                                                    _post.reportPost(post.id!),
                                              ),
                                            if (authuser?.id == post.user?.id)
                                              ListTile(
                                                tileColor:
                                                    Theme.of(context).cardColor,
                                                leading: Icon(
                                                  Icons.delete_outline_outlined,
                                                ),
                                                title: Text('delete_post'.tr),
                                                onTap: () =>
                                                    _post.deletePost(post.id!),
                                              ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Icon(
                                  Icons.more_vert_rounded,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (post.text != null && post.text != '')
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: HashTagText(
                        text: post.text ?? '',
                        decorateAtSign: true,
                        basicStyle: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        decoratedStyle: TextStyle(
                          color: primary,
                          fontSize: 16,
                        ),
                        onTap: (text) {
                          if (text.startsWith('@')) {
                            final username = text.substring(1);
                            if (authuser?.username == username) {
                              OnRoute.push(ProfilePage());
                            } else {
                              OnRoute.push(UserPage(
                                username: username,
                              ));
                            }
                          }
                          if (text.startsWith('#')) {
                            final hash = text.substring(1);
                            OnRoute.push(HashtagsPostsPage(hashtag: hash));
                          }
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
                  if ((medias?.length ?? 0) > 0) SizedBox(height: 8),
                  if ((medias?.length ?? 0) > 0)
                    SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: [
                          PageView(
                            controller: _pageController,
                            onPageChanged: (index) {
                              _post.changeMediaIndex(index);
                            },
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
                                  return GestureDetector(
                                    onDoubleTap: () => _post.likePost(),
                                    onTap: () => showImageModal(
                                      medias.map((e) => e.url!).toList(),
                                      index,
                                    ),
                                    child: ClipRRect(
                                      child: ImageNetwork(
                                        src: media.url,
                                        width: Size.infinite.width,
                                      ),
                                    ),
                                  );
                              },
                            ),
                          ),
                          if ((medias?.length ?? 0) > 1)
                            Positioned(
                              bottom: 10,
                              right: 0,
                              left: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: primary.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Row(
                                      children: List.generate(
                                        medias?.length ?? 0,
                                        (index) => Container(
                                          width: 10,
                                          height: 10,
                                          margin: EdgeInsets.only(left: 3),
                                          decoration: BoxDecoration(
                                            color: _post.mediaIndex == index
                                                ? primary
                                                : Colors.white.withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                        ],
                      ),
                    )
                ],
              ),
              if (showActions)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6).copyWith(top: 8),
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
                            Text('${post.cCount?.likes ?? 0}'),
                            SizedBox(width: 28),
                            IconButton(
                              onPressed: () => inPostItem
                                  ? null
                                  : OnRoute.push(PostPage(post: post)),
                              icon: Icon(
                                FeatherIcons.messageSquare,
                                size: 22,
                              ),
                            ),
                            Text('${post.cCount?.comments ?? 0}'),
                            SizedBox(width: 28),
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
                            Text('${post.cCount?.reposts ?? 0}'),
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
