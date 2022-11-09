import 'package:flutter/material.dart';

class FollowedsPage extends StatelessWidget {
  FollowedsPage({required this.userId});
  final int userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('seguindo'),
      ),
      body: Container(
        child: Text('seguindo'),
      ),
    );
  }
}
