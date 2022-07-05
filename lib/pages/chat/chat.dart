import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spalhe/components/layout/avatar/avatar.dart';
import 'package:spalhe/controllers/chat.controller.dart';
import 'package:spalhe/utils/date.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('chat'),
      ),
      body: GetBuilder<ChatController>(
        init: ChatController(),
        builder: (chatController) {
          final chats = chatController.chats.getChats;

          return ListView(
            padding: EdgeInsets.all(10),
            children: List.generate(
              chats?.length ?? 0,
              (index) => Padding(
                padding: const EdgeInsets.all(6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Avatar(
                          user: chats?[index].user,
                          width: 45,
                          heigth: 45,
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              chats![index].user!.name ?? '',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            Text(chats[index].messages?[0].text ?? ''),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      fromNow(
                        chats[index].messages?[0].createdAt ?? '',
                      ),
                      style: TextStyle(
                        fontSize: 12,
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
