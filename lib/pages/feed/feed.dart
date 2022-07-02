import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';
import 'package:spalhe/components/layout/image/image.dart';
import 'package:spalhe/controllers/auth.controller.dart';
import 'package:spalhe/controllers/posts.controller.dart';
import 'package:spalhe/controllers/settings.controller.dart';
import 'package:spalhe/pages/feed/moments/moments.dart';
import 'package:spalhe/pages/feed/post_item/post_item.dart';
import 'package:spalhe/pages/new_post/new_post.dart';
import 'package:spalhe/pages/profile/profile.dart';
import 'package:spalhe/pages/users/users.dart';
import 'package:spalhe/utils/routes.dart';

class FeedPage extends StatelessWidget {
  FeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _auth = Get.put(AuthController());
    final _post = Get.put(PostController());
    final _settings = Get.put(SettingsController());

    final user = _auth.auth.user;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 6,
        title: GestureDetector(
          onTap: () => OnRoute.push(ProfilePage(
            userId: user!.id!,
            myProfile: true,
          )),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: ImageNetwork(
                  src: user?.avatar ?? '',
                  width: 40,
                  height: 40,
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Opacity(
                    opacity: 0.6,
                    child: Text(
                      'Olá,',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  Text(
                    user?.name ?? '',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => OnRoute.push(NewPostPage()),
            icon: Icon(FeatherIcons.edit),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await _post.getPosts();
        },
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: MomentsComponent(),
            ),
            GetBuilder<PostController>(
              init: PostController(),
              builder: (_posts) {
                final posts = _posts.posts?.data;
                final totalPosts = posts?.length ?? 0;
                final loading = _posts.loading;

                if (loading) {
                  return Skeleton(
                    themeMode:
                        _settings.themeDark ? ThemeMode.dark : ThemeMode.light,
                    child: Container(),
                    isLoading: true,
                    skeleton: SkeletonItem(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                SizedBox(width: 8),
                                SkeletonLine(
                                  style: SkeletonLineStyle(
                                      height: 45,
                                      width: 45,
                                      borderRadius: BorderRadius.circular(60)),
                                ),
                                SizedBox(width: 14),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SkeletonLine(
                                      style: SkeletonLineStyle(
                                          height: 8,
                                          width: 200,
                                          borderRadius:
                                              BorderRadius.circular(60)),
                                    ),
                                    SizedBox(height: 6),
                                    SkeletonLine(
                                      style: SkeletonLineStyle(
                                          height: 6,
                                          width: 100,
                                          borderRadius:
                                              BorderRadius.circular(60)),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          SkeletonLine(
                            style: SkeletonLineStyle(
                                height: 400,
                                width: MediaQuery.of(context).size.width,
                                borderRadius: BorderRadius.circular(0)),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                if (totalPosts == 0) {
                  return Column(
                    children: [
                      SizedBox(height: 50),
                      SvgPicture.asset(
                        'assets/svg/feed.svg',
                        width: 200,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Nenhuma publicação encontrada',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => OnRoute.push(UsersPage()),
                        child: Text('encontrar amigos'),
                      )
                    ],
                  );
                }

                return Column(
                  children: List.generate(
                    totalPosts,
                    (index) => new PostItem(post: posts![index]),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
