import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:spalhe/components/layout/avatar/avatar.dart';
import 'package:spalhe/controllers/auth.controller.dart';
import 'package:spalhe/controllers/posts.controller.dart';
import 'package:spalhe/pages/feed/post_item/post_item.dart';
import 'package:spalhe/pages/profile/edit_profile.dart';
import 'package:spalhe/theme/colors.dart';
import 'package:spalhe/utils/routes.dart';

class ProfilePage extends StatelessWidget {
  final _posts = Get.put(PostController());

  ProfilePage({Key? key}) : super(key: key) {
    _posts.getByUserId(1);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
        init: AuthController(),
        builder: (_auth) {
          final user = _auth.auth.user;

          return Scaffold(
            appBar: AppBar(
              title: Text(user?.name ?? ''),
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
                                user?.name ?? '',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                '@' + (user?.username ?? ''),
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
                      if (user?.biography != '')
                        Column(
                          children: [
                            SizedBox(height: 14),
                            Text(
                              user?.biography ?? '',
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
                            '${user?.cCount?.followers}',
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
                            '${user?.cCount?.followed}',
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
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 14),
                          child: Text(
                            'posts',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 14),
                          child: Text(
                            'midias',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 14),
                          child: Text(
                            'menções',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 8),
                GetBuilder<PostController>(
                  init: PostController(),
                  builder: (_posts) {
                    final posts = _posts.userPost?.data;
                    final totalPosts = posts?.length ?? 0;

                    return Column(
                      children: List.generate(
                        totalPosts,
                        (index) => PostItem(post: posts![index]),
                      ),
                    );
                  },
                )
              ],
            ),
          );
        });
  }
}
