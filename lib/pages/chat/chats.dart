import 'package:flutter/material.dart';
import 'package:spalhe/controllers/chat.controller.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('chats'),
      ),
      body: RefreshIndicator(
        onRefresh: () => ChatController().getChats(),
        child: ListView(
          children: [],
        ),
      ),
    );
  }
}
