import 'package:flutter/material.dart';

class FollowersPage extends StatelessWidget {
  FollowersPage({required this.userId});
  final int userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('seguidores'),
      ),
      body: Container(
        child: Text('seguidores'),
      ),
    );
  }
}
