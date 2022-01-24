import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:spalhe/components/avatar/avatar.dart';
import 'package:spalhe/controllers/auth/auth.dart';
import 'package:spalhe/controllers/profile/profile.dart';
import 'package:spalhe/pages/profile/editprofile.dart';
import 'package:spalhe/pages/posts/components/postItem.dart';
import 'package:spalhe/pages/profile/preferences.dart';
import 'package:spalhe/pages/profile/components/photos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spalhe/theme/colors.dart';

class ProfilePage extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (_) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: GetBuilder<AuthController>(
            init: AuthController(),
            builder: (_auth) => Column(
              children: <Widget>[
                Text('@' + _auth.auth['user']['username']),
              ],
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(FeatherIcons.sliders),
              onPressed: () => Get.to(PreferencesPage()),
            )
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            _.getPosts();
            _.getPhotos();
            _.getProfile();
          },
          color: Colors.teal,
          child: ListView(
            children: <Widget>[
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                color: Theme.of(context).primaryColorLight,
                child: GetBuilder<AuthController>(
                  init: AuthController(),
                  builder: (_auth) => Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Avatar(
                                url: _.user['avatar'],
                                width: 90.0,
                                height: 90.0,
                                border: 100.0,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const SizedBox(height: 10),
                                  Text(
                                    '${_auth.auth['user']['name']}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  GestureDetector(
                                    onTap: () => Get.to(
                                      const EditProfilePage(),
                                    ),
                                    child: const Text(
                                      'Editar informações',
                                      style: TextStyle(color: primary),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        if (_auth.auth['user']['biography'] != null)
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            margin: const EdgeInsets.only(top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '@${_auth.auth['user']['username']}',
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  '${_auth.auth['user']['biography']}',
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              if (_.user['__meta__'] != null)
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorLight,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            'POSTS',
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context)
                                  .primaryColorDark
                                  .withOpacity(0.4),
                            ),
                          ),
                          Text(
                            '${_.user['__meta__']['posts_count']}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            'SEGUIDORES',
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context)
                                  .primaryColorDark
                                  .withOpacity(0.4),
                            ),
                          ),
                          Text(
                            '${_.user['__meta__']['followers_count']}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            'SEGUINDO',
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context)
                                  .primaryColorDark
                                  .withOpacity(0.4),
                            ),
                          ),
                          Text(
                            '${_.user['__meta__']['following_count']}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              else
                Container(
                  padding: const EdgeInsets.all(28.0),
                  color: Theme.of(context).primaryColorLight,
                  child: const Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                      ),
                    ),
                  ),
                ),
              Container(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      child: InkWell(
                        child: Icon(
                          FeatherIcons.alignCenter,
                          color: _.tabIndex == 0
                              ? Theme.of(context).primaryColorDark
                              : Theme.of(context)
                                  .primaryColorDark
                                  .withOpacity(0.34),
                        ),
                        onTap: () => _.onChangeIndexPage(0),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Icon(
                          FeatherIcons.image,
                          color: _.tabIndex == 1
                              ? Theme.of(context).primaryColorDark
                              : Theme.of(context)
                                  .primaryColorDark
                                  .withOpacity(0.34),
                        ),
                        onTap: () => _.onChangeIndexPage(1),
                      ),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorLight,
                ),
              ),
              const SizedBox(height: 10),
              IndexedStack(
                index: _.tabIndex,
                children: <Widget>[
                  Column(
                    children: List.generate(_.posts.length, (index) {
                      return PostItem(post: _.posts[index]);
                    }),
                  ),
                  GridImages(_.photos),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
