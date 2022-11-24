import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spalhe/components/layout/avatar/avatar.dart';
import 'package:spalhe/controllers/chat.controller.dart';
import 'package:spalhe/models/chat.model.dart';
import 'package:spalhe/pages/chat/chat.dart';
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
          appBar: AppBar(
            title: Text('chats'),
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              chatController.getChats();
            },
            child: ListView(
              padding: EdgeInsets.all(14),
              children: [
                for (GetChats chat in chats)
                  GestureDetector(
                    onTap: () => Get.to(
                      ChatPage(chat: chat),
                    ),
                    child: Container(
                        padding: EdgeInsets.all(16),
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Avatar(
                              user: chat.user!,
                              width: 40,
                              heigth: 40,
                              showIcon: false,
                            ),
                            SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    chat.isGroup == true
                                        ? chat.name ?? ''
                                        : chat.user?.username ?? '',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                  Text(
                                    chat.lastMessage?.message ?? '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
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
                            )
                          ],
                        )),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
