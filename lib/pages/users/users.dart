import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spalhe/components/layout/avatar/avatar.dart';
import 'package:spalhe/controllers/users.controller.dart';
import 'package:spalhe/pages/user/user.dart';
import 'package:spalhe/utils/routes.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('pessoas para seguir'),
      ),
      body: GetBuilder<UserController>(
        init: UserController(),
        builder: (usersController) {
          final users = usersController.users?.data;

          return RefreshIndicator(
            onRefresh: () async {
              await usersController.getUsers(filters: {
                'per_page': 21,
              });
            },
            child: GridView(
              padding: EdgeInsets.all(14).copyWith(bottom: 50),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 20,
                childAspectRatio: 0.7,
              ),
              children: List.generate(
                users?.length ?? 0,
                (index) {
                  final followed = users?[index].followed == 'following';
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
                                foregroundColor:
                                    followed ? Colors.black87 : null,
                                backgroundColor:
                                    followed ? Colors.grey.shade300 : null,
                              ),
                              onPressed: () {
                                usersController.followUser(
                                    users[index].id!, index);
                              },
                              child:
                                  followed ? Text('seguindo') : Text('seguir'),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
