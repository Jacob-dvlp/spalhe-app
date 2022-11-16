import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_gif_picker/modal_gif_picker.dart';
import 'package:spalhe/components/layout/image/image.dart';
import 'package:spalhe/controllers/auth.controller.dart';
import 'package:spalhe/controllers/messages.controller.dart';
import 'package:spalhe/models/chat.model.dart';
import 'package:spalhe/theme/colors.dart';
import 'package:spalhe/utils/date.dart';

class ChatPage extends StatelessWidget {
  final GetChats chat;
  final _authController = Get.put(AuthController());

  ChatPage({required this.chat}) {
    final _messageController = Get.put(MessagesController(), tag: '${chat.id}');

    _messageController.getMessages(chat.id);
    _messageController.setViewedMessages(chat.id);
  }

  @override
  Widget build(BuildContext context) {
    final user = chat.user;

    return GetBuilder<MessagesController>(
      init: MessagesController(),
      autoRemove: true,
      global: true,
      assignId: true,
      tag: '${chat.id}',
      builder: (chatController) {
        final _messages = chatController.messages;
        final authUser = _authController.auth.user;

        final isOnline = chatController.isOnline;

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
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user?.name ?? '',
                    ),
                    if (isOnline)
                      Opacity(
                        opacity: 0.7,
                        child: Text(
                          'Online',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                  ],
                ),
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

                      final file = message.files?.url;
                      final gif = message.gif;

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
                            child: Column(
                              children: [
                                if (file == null && gif == null)
                                  Text(
                                    message.message ?? '',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                if (file != null)
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.memory(
                                        (base64Decode(file)),
                                        width: 250,
                                      ),
                                    ),
                                  ),
                                if (gif != null)
                                  GiphyRenderImage.original(
                                    gif: gif,
                                    width: 150,
                                    placeholder: Container(
                                      width: 150,
                                      height: 150,
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                  )
                              ],
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
                      IconButton(
                        icon: Icon(Icons.image),
                        onPressed: () {
                          chatController.sendFile(chat.id!);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.gif),
                        onPressed: () {
                          chatController.sendGiphy(chat.id!);
                        },
                      ),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: TextField(
                            controller: chatController.textController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: 'Inserir mensagem',
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                              filled: true,
                              fillColor: Get.theme.scaffoldBackgroundColor,
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
