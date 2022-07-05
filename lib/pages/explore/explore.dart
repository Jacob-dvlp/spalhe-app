import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:spalhe/components/layout/avatar/avatar.dart';
import 'package:spalhe/controllers/profile.controller.dart';
import 'package:spalhe/controllers/users.controller.dart';
import 'package:spalhe/pages/user/user.dart';
import 'package:spalhe/utils/routes.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        title: Text('descobrir'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Text(
            'novos usuarios',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          SizedBox(
            height: 140,
            child: GetBuilder<UserController>(
              init: UserController(),
              builder: (usesrsController) {
                final users = usesrsController.users?.data;

                return ListView(
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                    users?.length ?? 0,
                    (index) => GestureDetector(
                      onTap: () => OnRoute.push(UserPage(
                        userId: users![index].id!,
                      )),
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        width: 120,
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
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (users[index].username != null)
                              Text(
                                '@${users[index].username ?? ''}',
                                style: TextStyle(
                                  fontSize: 11,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            SizedBox(height: 4),
                            SizedBox(
                              height: 23,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  profileController.follow(users[index].id!);
                                },
                                child: Text('seguir'),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
