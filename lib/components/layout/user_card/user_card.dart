import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spalhe/components/layout/avatar/avatar.dart';
import 'package:spalhe/components/layout/verified/verified.dart';
import 'package:spalhe/controllers/auth.controller.dart';
import 'package:spalhe/controllers/users.controller.dart';
import 'package:spalhe/models/user.model.dart';
import 'package:spalhe/pages/profile/profile.dart';
import 'package:spalhe/pages/user/user.dart';
import 'package:spalhe/utils/routes.dart';

class UserCard extends StatefulWidget {
  final UserModel user;

  const UserCard({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  bool followed = false;

  @override
  void initState() {
    if (widget.user.followed == 'following') {
      followed = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());
    final userController = Get.put(UserController());
    final authuser = authController.auth.user;

    return Container(
      child: InkWell(
        onTap: () {
          if (authuser?.id == widget.user.id) {
            OnRoute.push(ProfilePage());
          } else {
            OnRoute.push(UserPage(
              userId: widget.user.id,
            ));
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Row(
            children: [
              Avatar(
                user: widget.user,
                heigth: 45,
                width: 45,
                iconSize: 15,
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            widget.user.name ?? '',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        SizedBox(width: 4),
                        VerifiedComponent(
                          user: widget.user,
                          iconSize: 14,
                        )
                      ],
                    ),
                    Opacity(
                      opacity: 0.6,
                      child: Text(
                        '@${widget.user.username ?? ''}',
                        style: TextStyle(
                          fontSize: 11,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(width: 20),
              if (authuser?.id != widget.user.id)
                SizedBox(
                  height: 23,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: followed ? Colors.black87 : null,
                      backgroundColor: followed ? Colors.grey.shade300 : null,
                    ),
                    onPressed: () {
                      setState(() {
                        followed = !followed;
                      });
                      userController.followUser(widget.user.id!);
                    },
                    child: followed ? Text('seguindo') : Text('seguir'),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
