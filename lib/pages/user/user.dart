import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:spalhe/components/avatar/avatar.dart';
import 'package:spalhe/controllers/user/user.dart';
import 'package:spalhe/pages/messages/message.dart';
import 'package:spalhe/pages/posts/components/postItem.dart';
import 'package:spalhe/pages/profile/components/photos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserPage extends StatelessWidget {
  final user;
  const UserPage({Key? key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      init: UserController(user),
      builder: (_) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Column(
            children: <Widget>[Text("@${_.user['username']}")],
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                FeatherIcons.messageCircle,
                size: 24,
              ),
              onPressed: () => Get.to(MessagePage(user: _.user)),
            )
          ],
        ),
        //
        // BODY
        body: ListView(
          children: <Widget>[
            if (_.user.isNotEmpty)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                color: Theme.of(context).primaryColorLight,
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
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const SizedBox(height: 10),
                              Text(
                                '${_.user['name']}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 10),
                              if (_.user['__meta__'] != null)
                                Row(
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                      ),
                                      onPressed: _.user['followed'] != null
                                          ? _.unfollowUser
                                          : _.followUser,
                                      child: Row(
                                        children: [
                                          if (_.user['followed'] != null)
                                            const Icon(Icons.check, size: 18),
                                          const SizedBox(width: 6),
                                          Text(_.user['followed'] != null
                                              ? 'Seguindo '
                                              : 'Seguir'),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    IconButton(
                                      onPressed: () =>
                                          Get.to(MessagePage(user: _.user)),
                                      icon: const Icon(
                                        FeatherIcons.messageCircle,
                                        size: 24,
                                      ),
                                    )
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    if (_.user['biography'] != null)
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        margin: const EdgeInsets.only(top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '@${_.user['username']}',
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '${_.user['biography']}',
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            if (_.user['__meta__'] != null)
              Container(
                decoration:
                    BoxDecoration(color: Theme.of(context).primaryColorLight),
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorLight),
                      child: Column(
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
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorLight),
                      child: Column(
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
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorLight,
                      ),
                      child: Column(
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
                      ),
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
                  InkWell(
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
                  InkWell(
                    child: Icon(
                      FeatherIcons.image,
                      color: _.tabIndex == 1
                          ? Theme.of(context).primaryColorDark
                          : Theme.of(context)
                              .primaryColorDark
                              .withOpacity(0.34),
                    ),
                    onTap: () => _.onChangeIndexPage(1),
                  )
                ],
              ),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorLight,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Theme.of(context).shadowColor.withOpacity(0.06),
                      offset: const Offset(0, 3),
                      blurRadius: 2,
                    )
                  ]),
            ),
            IndexedStack(
              key: const ValueKey<int>(1),
              index: _.tabIndex,
              children: <Widget>[
                ListView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _.posts.length,
                  itemBuilder: (context, index) {
                    return PostItem(post: _.posts[index]);
                  },
                ),
                GridImages(_.photos),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
