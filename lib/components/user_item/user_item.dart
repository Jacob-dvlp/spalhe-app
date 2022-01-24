import 'package:spalhe/components/avatar/avatar.dart';
import 'package:spalhe/utils/utils.dart';
import 'package:flutter/material.dart';

class UserItem extends StatelessWidget {
  final Map user;
  const UserItem({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Utils.routeUser(user),
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Avatar(url: user['avatar'], width: 40.0, height: 40.0),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user['name'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColorDark.withOpacity(0.95),
                  ),
                ),
                Text(
                  '@' + user['username'],
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).primaryColorDark.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
