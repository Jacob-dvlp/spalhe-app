import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spalhe/components/layout/image/image.dart';
import 'package:spalhe/controllers/profile.controller.dart';
import 'package:spalhe/controllers/users.controller.dart';
import 'package:spalhe/pages/profile/profile.dart';
import 'package:spalhe/utils/routes.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        title: Text('pessoas para seguir'),
      ),
      body: GetBuilder<UserController>(
        init: UserController(),
        builder: (userController) {
          final users = userController.users.data;

          return GridView(
            padding: EdgeInsets.all(14),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 20,
              childAspectRatio: 0.7,
            ),
            children: List.generate(
              users?.length ?? 0,
              (index) => GestureDetector(
                onTap: () => OnRoute.push(ProfilePage(
                  userId: users![index].id!,
                )),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: ImageNetwork(
                        src: users?[index].avatar,
                        height: 60,
                        width: 60,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      users?[index].name ?? '',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '@${users?[index].username ?? ''}',
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
                          profileController.follow(users![index].id!);
                        },
                        child: Text('seguir'),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
