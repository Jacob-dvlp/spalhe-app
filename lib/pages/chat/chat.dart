import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spalhe/components/layout/avatar/avatar.dart';
import 'package:spalhe/controllers/auth.controller.dart';
import 'package:spalhe/controllers/chat.controller.dart';
import 'package:spalhe/models/user.model.dart';
import 'package:spalhe/theme/colors.dart';

class ChatPage extends StatelessWidget {
  final _chatController = Get.put(ChatController());
  final _authController = Get.put(AuthController());
  final UserModel user;
  final int chatId;

  ChatPage({required this.user, required this.chatId}) {
    _chatController.getChatMessages(chatId);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
      init: ChatController(),
      builder: (chatController) {
        final _messages = chatController.messages;
        final authUser = _authController.auth.user;

        return Scaffold(
          appBar: AppBar(
            leadingWidth: 26,
            title: Row(
              children: [
                Avatar(
                  user: user,
                  width: 32,
                  heigth: 32,
                ),
                SizedBox(width: 6),
                Text(user.name ?? ''),
              ],
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  reverse: true,
                  padding: EdgeInsets.all(20),
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: List.generate(_messages.length, (index) {
                      final message = _messages[index];
                      final byMe = authUser?.id == message.user?.id;

                      return Container(
                        width: MediaQuery.of(context).size.width,
                        alignment:
                            byMe ? Alignment.topRight : Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: byMe
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: !byMe
                                      ? [
                                          primary,
                                          Color.fromARGB(255, 255, 214, 68)
                                        ]
                                      : [
                                          Color.fromARGB(255, 201, 201, 201),
                                          Color.fromARGB(255, 233, 231, 231)
                                        ],
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                message.text ?? '',
                                style: TextStyle(
                                  color: byMe ? Colors.black : null,
                                ),
                              ),
                            ),
                            Opacity(
                              opacity: 0.6,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      '10:20h',
                                      style: TextStyle(fontSize: 10),
                                    ),
                                    if (message.viewed == true)
                                      Text(
                                        ' - visualizada',
                                        style: TextStyle(fontSize: 10),
                                      )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorLight.withOpacity(1),
                ),
                child: SafeArea(
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: chatController.textController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'Inserir mensagem',
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.send_rounded),
                        onPressed: () {
                          chatController.sendMessage(
                            user.id!,
                            chatController.textController.text,
                          );
                          chatController.textController.text = '';
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
