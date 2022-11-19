import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spalhe/components/layout/avatar/avatar.dart';
import 'package:spalhe/controllers/profile.controller.dart';
import 'package:spalhe/controllers/users.controller.dart';
import 'package:spalhe/pages/user/user.dart';
import 'package:spalhe/utils/routes.dart';

class NewUsers extends StatelessWidget {
  const NewUsers({
    Key? key,
    required this.profileController,
  }) : super(key: key);

  final ProfileController profileController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'recommended_users'.tr,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // TextButton(onPressed: () {}, child: Text('ver mais'))
            ],
          ),
        ),
        Divider(),
        SizedBox(
          height: 136,
          child: GetBuilder<UserController>(
            init: UserController(),
            builder: (usersController) {
              final users = usersController.users.data;

              return ListView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
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
                                child: followed
                                    ? Text('following'.tr)
                                    : Text('follow'.tr),
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
    );
  }
}
