import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spalhe/components/layout/list_view_wraper/list_view.dart';
import 'package:spalhe/controllers/explore.controller.dart';
import 'package:spalhe/controllers/hashtags.controller.dart';
import 'package:spalhe/controllers/profile.controller.dart';
import 'package:spalhe/controllers/users.controller.dart';
import 'package:spalhe/pages/explore/components/explore_medias.dart';
import 'package:spalhe/pages/explore/components/new_users.dart';
import 'package:spalhe/pages/search/search.dart';

import 'components/hastags.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(ProfileController());
    final hashtagsController = Get.put(HashtagsController());
    final userController = Get.put(UserController());
    final exploreController = Get.put(ExploreController());

    return Scaffold(
      backgroundColor: Get.theme.primaryColorLight,
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.all(2),
          child: GestureDetector(
            onTap: () => Get.to(() => SearchPage()),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: Get.theme.scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'busque pelo nome ou nome de usuário',
                style: TextStyle(
                  color: Get.theme.primaryColorDark.withOpacity(0.3),
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert_rounded),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await hashtagsController.getHashtags();
          await userController.getUsers();
          await exploreController.getPostMedia();
        },
        child: ListViewWraper(
          children: [
            HashtagsWidget(),
            NewUsers(profileController: profileController),
            ExploreMidias(),
          ],
        ),
      ),
    );
  }
}
