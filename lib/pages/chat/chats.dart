import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spalhe/components/layout/image/image.dart';
import 'package:spalhe/controllers/chat.controller.dart';
import 'package:spalhe/models/chat.model.dart';
import 'package:spalhe/pages/chat/chat.dart';
import 'package:spalhe/theme/colors.dart';
import 'package:spalhe/utils/date.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
      init: ChatController(),
      builder: (chatController) {
        final chats = chatController.chats.getChats ?? [];
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: primary,
            onPressed: () {
              Get.toNamed('/chat');
            },
            child: Icon(Icons.message),
          ),
          appBar: AppBar(
            title: Text('chats'),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.search),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.more_vert_rounded),
              ),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () => ChatController().getChats(),
            child: ListView(
              children: [
                for (GetChats chat in chats)
                  ListTile(
                    tileColor: Colors.transparent,
                    textColor: Get.theme.textTheme.bodyLarge?.color,
                    leading: CircleAvatar(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: ImageNetwork(
                          src: chat.isGroup == true
                              ? chat.avatar
                              : chat.user?.avatar,
                        ),
                      ),
                    ),
                    title: Text(chat.isGroup == true
                        ? chat.name ?? ''
                        : chat.user?.name ?? ''),
                    subtitle: Text(chat.lastMessage?.message ?? ''),
                    onTap: () => Get.to(
                      ChatPage(chat: chat),
                    ),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          fromNow(chat.lastMessage?.createdAt),
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        if (chat.countUnreadMessages! > 0)
                          Container(
                            width: 20,
                            height: 20,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              chat.countUnreadMessages.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
