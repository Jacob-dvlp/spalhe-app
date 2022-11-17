import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spalhe/components/layout/avatar/avatar.dart';
import 'package:spalhe/controllers/users.controller.dart';
import 'package:spalhe/pages/user/user.dart';
import 'package:spalhe/utils/routes.dart';

class BlockedUsersPage extends StatelessWidget {
  final UserController _userController = Get.find<UserController>();

  BlockedUsersPage() {
    _userController.getBlockedUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('usuários bloqueadas'),
      ),
      body: GetBuilder<UserController>(
        init: UserController(),
        builder: (usersController) {
          final users = usersController.blockedUsers.data;

          return RefreshIndicator(
            onRefresh: () async {
              await usersController.getUsers(filters: {
                'per_page': 21,
              });
            },
            child: Column(
              children: [
                if (users?.isEmpty == true)
                  Expanded(
                    child: Center(
                      child: Text('nenhum usuário bloqueado'),
                    ),
                  ),
                Expanded(
                  child: GridView(
                    padding: EdgeInsets.all(14).copyWith(bottom: 50),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.7,
                    ),
                    children: List.generate(
                      users?.length ?? 0,
                      (index) {
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
                                    onPressed: () {
                                      usersController
                                          .blockUser(users[index].id!);
                                    },
                                    child: Text('desbloquear'),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
