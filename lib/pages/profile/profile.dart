import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:spalhe/components/layout/avatar/avatar.dart';
import 'package:spalhe/controllers/auth.controller.dart';

import 'package:spalhe/controllers/posts.controller.dart';
import 'package:spalhe/controllers/profile.controller.dart';
import 'package:spalhe/pages/profile/components/button_tab.dart';
import 'package:spalhe/pages/profile/edit_profile.dart';
import 'package:spalhe/pages/profile/tabs/medias.tab.dart';
import 'package:spalhe/pages/profile/tabs/mentions.tab.dart';
import 'package:spalhe/pages/profile/tabs/post.tab.dart';
import 'package:spalhe/theme/colors.dart';
import 'package:spalhe/utils/routes.dart';

class ProfilePage extends StatelessWidget {
  final _posts = Get.put(PostController());

  ProfilePage({Key? key}) : super(key: key) {
    _posts.getByUserId(1);
    _posts.getPostMedia(1);
    _posts.getPostMentions(1);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (authController) {
        final user = authController.auth.user!;

        return Scaffold(
          appBar: AppBar(
            title: Text(user.name ?? ''),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(FeatherIcons.settings),
              )
            ],
          ),
          body: ListView(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: primary,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Avatar(
                      user: user,
                      width: 120,
                      heigth: 120,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name ?? '',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              '@' + (user.username ?? ''),
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.grey.shade300,
                            elevation: 0,
                            onPrimary: Colors.black87,
                          ),
                          onPressed: () => OnRoute.push(EditProfilePage()),
                          child: Text('editar perfil'),
                        )
                      ],
                    ),
                    if (user.biography != '')
                      Column(
                        children: [
                          SizedBox(height: 14),
                          Text(
                            user.biography ?? '',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          '${user.cCount?.followers}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          'seguindo',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(width: 20),
                        Text(
                          '${user.cCount?.followed}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          'seguidores',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 1),
              GetBuilder<ProfileController>(
                init: ProfileController(),
                builder: (profileController) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        ButtonTabProfile(
                          title: 'posts',
                          onPress: () {
                            profileController.changeIndex(0);
                          },
                          isActive: profileController.tab == 0,
                        ),
                        ButtonTabProfile(
                          title: 'midias',
                          onPress: () {
                            profileController.changeIndex(1);
                          },
                          isActive: profileController.tab == 1,
                        ),
                        ButtonTabProfile(
                          title: 'menções',
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
              )
            ],
          ),
        );
      },
    );
  }
}
