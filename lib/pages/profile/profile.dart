import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hashtagable/hashtagable.dart';
import 'package:spalhe/components/layout/avatar/avatar.dart';
import 'package:spalhe/components/layout/list_view_wraper/list_view.dart';
import 'package:spalhe/controllers/auth.controller.dart';
import 'package:spalhe/controllers/posts.controller.dart';
import 'package:spalhe/controllers/profile.controller.dart';
import 'package:spalhe/pages/explore/pages/hashtags_posts/hashtags_posts.dart';
import 'package:spalhe/pages/profile/components/button_tab.dart';
import 'package:spalhe/pages/profile/edit_profile.dart';
import 'package:spalhe/pages/profile/pages/followers/followeds.dart';
import 'package:spalhe/pages/profile/pages/followers/followers.dart';
import 'package:spalhe/pages/profile/tabs/medias.tab.dart';
import 'package:spalhe/pages/profile/tabs/mentions.tab.dart';
import 'package:spalhe/pages/profile/tabs/post.tab.dart';
import 'package:spalhe/pages/account/account.dart';
import 'package:spalhe/pages/user/user.dart';
import 'package:spalhe/theme/colors.dart';
import 'package:spalhe/utils/numbers.dart';
import 'package:spalhe/utils/routes.dart';

class ProfilePage extends StatelessWidget {
  final _posts = Get.put(PostController());
  final _auth = Get.put(AuthController());

  ProfilePage() {
    final userId = _auth.auth.user!.id!;
    _auth.getUser();
    _posts.getUserPosts(userId);
    _posts.getPostMedia(userId);
    _posts.getPostMentions(userId);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      global: true,
      autoRemove: false,
      builder: (authController) {
        final user = authController.auth.user!;

        return Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(user.name ?? ''),
                if (user.verified == true)
                  Row(
                    children: [
                      SizedBox(width: 6),
                      Container(
                        child: SvgPicture.asset(
                          'assets/svg/veirified.svg',
                          width: 17,
                          height: 17,
                        ),
                      ),
                    ],
                  )
              ],
            ),
            actions: [
              IconButton(
                onPressed: () => OnRoute.push(AccountPage()),
                icon: Icon(FeatherIcons.settings),
              )
            ],
          ),
          body: ListViewWraper(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: primary,
                  image: user.cover != null
                      ? DecorationImage(
                          image: NetworkImage(user.cover ?? ''),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Avatar(
                      user: user,
                      width: 120,
                      heigth: 120,
                      showIcon: false,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Get.theme.primaryColorLight,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  user.name ?? '',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(width: 6),
                                if (user.verified == true)
                                  Container(
                                    child: SvgPicture.asset(
                                      'assets/svg/veirified.svg',
                                      width: 16,
                                      height: 16,
                                    ),
                                  )
                              ],
                            ),
                            if (user.username != null)
                              Opacity(
                                opacity: 0.6,
                                child: Text(
                                  '@' + (user.username ?? ''),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black87,
                            backgroundColor: Colors.grey.shade300,
                            elevation: 0,
                          ),
                          onPressed: () => OnRoute.push(EditProfilePage()),
                          child: Text('edit_profile'.tr),
                        ),
                      ],
                    ),
                    if (user.biography != '' && user.biography != null)
                      Column(
                        children: [
                          SizedBox(height: 10),
                          HashTagText(
                            text: user.biography ?? '',
                            decorateAtSign: true,
                            basicStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            decoratedStyle: TextStyle(
                              color: primary,
                              fontSize: 14,
                            ),
                            onTap: (text) {
                              if (text.startsWith('@')) {
                                final username = text.substring(1);
                                if (user.username == username) {
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
                          )
                        ],
                      ),
                    SizedBox(height: 14),
                    Row(
                      children: [
                        InkWell(
                          onTap: () => OnRoute.push(FollowedsPage(
                            userId: user.id!,
                          )),
                          child: Row(
                            children: [
                              Text(
                                '${formatToNumberString(user.profileDetails?.followed ?? 0)}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(width: 5),
                              Text(
                                'following'.tr,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 20),
                        InkWell(
                          onTap: () => OnRoute.push(FollowersPage(
                            userId: user.id!,
                          )),
                          child: Row(
                            children: [
                              Text(
                                '${formatToNumberString(user.profileDetails?.followers ?? 0)}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(width: 5),
                              Text(
                                'followers'.tr,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 1),
              GetBuilder<ProfileController>(
                global: true,
                autoRemove: false,
                init: ProfileController(),
                builder: (profileController) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorLight,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ButtonTabProfile(
                          icon: FeatherIcons.alignCenter,
                          total: user.profileDetails?.posts ?? 0,
                          onPress: () {
                            profileController.changeIndex(0);
                          },
                          isActive: profileController.tab == 0,
                        ),
                        ButtonTabProfile(
                          icon: FeatherIcons.grid,
                          total: user.profileDetails?.medias ?? 0,
                          onPress: () {
                            profileController.changeIndex(1);
                          },
                          isActive: profileController.tab == 1,
                        ),
                        ButtonTabProfile(
                          icon: FeatherIcons.atSign,
                          total: user.profileDetails?.mentions ?? 0,
                          onPress: () {
                            profileController.changeIndex(2);
                          },
                          isActive: profileController.tab == 2,
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 8),
              GetBuilder<ProfileController>(
                global: true,
                autoRemove: false,
                init: ProfileController(),
                builder: (profileController) {
                  return IndexedStack(
                    index: profileController.tab,
                    children: [
                      PostTab(),
                      MediasTab(),
                      PostMentionsTab(),
                    ],
                  );
                },
              ),
              SizedBox(height: 50),
            ],
          ),
        );
      },
    );
  }
}
