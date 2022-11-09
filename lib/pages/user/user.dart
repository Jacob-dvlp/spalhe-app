import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:spalhe/components/layout/avatar/avatar.dart';
import 'package:spalhe/components/layout/list_view_wraper/list_view.dart';
import 'package:spalhe/controllers/chat.controller.dart';
import 'package:spalhe/controllers/posts.controller.dart';
import 'package:spalhe/controllers/profile.controller.dart';
import 'package:spalhe/controllers/users.controller.dart';
import 'package:spalhe/pages/profile/components/button_tab.dart';
import 'package:spalhe/pages/profile/tabs/medias.tab.dart';
import 'package:spalhe/pages/profile/tabs/mentions.tab.dart';
import 'package:spalhe/pages/profile/tabs/post.tab.dart';
import 'package:spalhe/theme/colors.dart';
import 'package:spalhe/utils/numbers.dart';
import 'package:spalhe/utils/routes.dart';

import '../../components/layout/dialog/dialog.dart';

class UserPage extends StatelessWidget {
  final _posts = Get.put(PostController());
  final _profileController = Get.put(ProfileController());

  final int userId;

  UserPage({required this.userId, Key? key}) : super(key: key) {
    _profileController.reset();
    _profileController.getUser(userId);
    _posts.getUserPosts(userId);
    _posts.getPostMedia(userId);
    _posts.getPostMentions(userId);
  }

  sendMessage() {
    final ChatController chatController = Get.put(ChatController());
    chatController.createChat(userId);
  }

  blockUser() {
    showDialogModal(
      title: 'Bloquear usuário',
      description: 'Deseja bloquear este usuário?',
      onConfirm: () {
        _profileController.blockUser(userId);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (profileController) {
        final user = profileController.profile;
        final isLoading = profileController.isLoading;

        if (user.id == null && isLoading == false) {
          return Scaffold(
            appBar: AppBar(
              title: Text(user.name ?? ''),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sentimos muito!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Esse perfil não está disponível pra você.',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        if (user.id == null && isLoading) {
          return Scaffold(
            appBar: AppBar(
              title: Text(user.name ?? ''),
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(user.name ?? ''),
            actions: [
              IconButton(
                onPressed: () => showModalBottomSheet(
                  backgroundColor: Theme.of(context).cardColor,
                  context: context,
                  builder: (BuildContext bc) {
                    return SafeArea(
                      child: Wrap(
                        children: [
                          ListTile(
                            tileColor: Theme.of(context).cardColor,
                            leading: Icon(
                              FeatherIcons.userX,
                            ),
                            title: Text('bloquear usuário'),
                            onTap: blockUser,
                          ),
                        ],
                      ),
                    );
                  },
                ),
                icon: Icon(FeatherIcons.moreVertical),
              ),
            ],
          ),
          body: ListViewWraper(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: primary,
                  image: DecorationImage(
                    image: NetworkImage(user.cover ?? ''),
                    fit: BoxFit.cover,
                  ),
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
                            Text(
                              user.name ?? '',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            if (user.username != null)
                              Text(
                                '@' + (user.username ?? ''),
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                    if (user.biography != '' && user.biography != null)
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
                          '${formatToNumberString(user.profileDetails?.followers ?? 0)}',
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
                          '${formatToNumberString(user.profileDetails?.followed ?? 0)}',
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
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (user.followed == 'following')
                          Flexible(
                            child: Row(
                              children: [
                                Flexible(
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.black87,
                                        backgroundColor: Colors.grey.shade300,
                                        elevation: 0,
                                      ),
                                      onPressed: () =>
                                          profileController.follow(user.id!),
                                      child: Text('deixar de seguir'),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Flexible(
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        backgroundColor: primary,
                                      ),
                                      onPressed: sendMessage,
                                      child: Text('mensagem'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (user.followed != 'following')
                          Flexible(
                            child: Row(
                              children: [
                                Flexible(
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                      ),
                                      onPressed: () =>
                                          profileController.follow(user.id!),
                                      child: Text('Seguir ${user.name}'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: profileController.showMoreUsers
                                ? Get.theme.primaryColorDark.withOpacity(0.4)
                                : Get.theme.primaryColorDark.withOpacity(0.1),
                          ),
                          onPressed: profileController.toggleShowMoreUsers,
                          child: Icon(
                            profileController.showMoreUsers
                                ? FeatherIcons.userMinus
                                : FeatherIcons.userPlus,
                            size: 20,
                            color: Get.theme.primaryColorDark,
                          ),
                        )
                      ],
                    ),
                    if (profileController.showMoreUsers) SizedBox(height: 20),
                    if (profileController.showMoreUsers)
                      SizedBox(
                        height: 150,
                        child: GetBuilder<UserController>(
                          init: UserController(),
                          builder: (usersController) {
                            final users = usersController.users?.data;
                            return ListView(
                              padding: EdgeInsets.symmetric(horizontal: 0),
                              scrollDirection: Axis.horizontal,
                              children: List.generate(
                                users?.length ?? 0,
                                (index) {
                                  final followed =
                                      users?[index].followed == 'following';

                                  return GestureDetector(
                                    onTap: () => OnRoute.push(UserPage(
                                      userId: users![index].id!,
                                    )),
                                    child: Container(
                                      margin: EdgeInsets.only(right: 10),
                                      width: 130,
                                      child: Column(
                                        children: [
                                          Avatar(
                                            user: users![index],
                                            width: 60,
                                            heigth: 60,
                                            iconSize: 14,
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            users[index].name ?? '',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            users[index].username != null
                                                ? '@${users[index].username}'
                                                : '',
                                            style: TextStyle(
                                              fontSize: 11,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 8),
                                          SizedBox(
                                            height: 23,
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                foregroundColor: followed
                                                    ? Colors.black87
                                                    : null,
                                                backgroundColor: followed
                                                    ? Colors.grey.shade300
                                                    : null,
                                              ),
                                              onPressed: () {
                                                usersController.followUser(
                                                    users[index].id!, index);
                                              },
                                              child: followed
                                                  ? Text('seguindo')
                                                  : Text('seguir'),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 1),
              GetBuilder<ProfileController>(
                init: ProfileController(),
                builder: (profileController) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Get.theme.primaryColorLight,
                    ),
                    child: Row(
                      children: [
                        ButtonTabProfile(
                          title: 'posts',
                          total: user.profileDetails?.posts ?? 0,
                          onPress: () {
                            profileController.changeIndex(0);
                          },
                          isActive: profileController.tab == 0,
                        ),
                        ButtonTabProfile(
                          title: 'midias',
                          total: user.profileDetails?.medias ?? 0,
                          onPress: () {
                            profileController.changeIndex(1);
                          },
                          isActive: profileController.tab == 1,
                        ),
                        ButtonTabProfile(
                          title: 'menções',
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
