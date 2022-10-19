import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spalhe/components/layout/image/image.dart';
import 'package:spalhe/controllers/auth.controller.dart';
import 'package:spalhe/controllers/messages.controller.dart';
import 'package:spalhe/models/chat.model.dart';
import 'package:spalhe/theme/colors.dart';
import 'package:spalhe/utils/date.dart';

class ChatPage extends StatelessWidget {
  final GetChats chat;
  final _authController = Get.put(AuthController());
  final _messageController = Get.put(MessagesController());

  ChatPage({required this.chat}) {
    _messageController.setChatId(chat.id);
    _messageController.getChatMessages(chat.id!);
    _messageController.setViewedMessages();
  }

  @override
  Widget build(BuildContext context) {
    final user = chat.user;

    return GetBuilder<MessagesController>(
      init: _messageController,
      autoRemove: true,
      global: false,
      builder: (chatController) {
        final _messages = chatController.messages;
        final authUser = _authController.auth.user;

        return Scaffold(
          appBar: AppBar(
            leadingWidth: 26,
            title: Row(
              children: [
                CircleAvatar(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: ImageNetwork(
                      src: chat.isGroup == true
                          ? chat.avatar
                          : chat.user?.avatar,
                    ),
                  ),
                ),
                SizedBox(width: 6),
                Text(user?.name ?? ''),
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

                      return Column(
                        crossAxisAlignment: byMe
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
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
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              message.message ?? '',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(height: 2),
                          Row(
                            mainAxisAlignment: byMe
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Text(
                                  fromNow(message.createdAt),
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                            ],
                          )
                        ],
                      );
                    }),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(25),
                  ),
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
                            chat.id!,
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
