import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spalhe/components/layout/avatar/avatar.dart';
import 'package:spalhe/components/layout/list_view_wraper/list_view.dart';
import 'package:spalhe/controllers/chat.controller.dart';
import 'package:spalhe/pages/chat/chat.dart';
import 'package:spalhe/theme/colors.dart';
import 'package:spalhe/utils/date.dart';
import 'package:spalhe/utils/routes.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('chats'),
      ),
      body: GetBuilder<ChatController>(
        init: ChatController(),
        builder: (chatController) {
          final chats = chatController.chats.getChats;

          if (chats?.isEmpty == true) return Container();

          return RefreshIndicator(
            onRefresh: () => chatController.getChats(),
            child: ListViewWraper(
              padding: EdgeInsets.all(10),
              children: List.generate(
                chats?.length ?? 0,
                (index) => InkWell(
                  onTap: () => OnRoute.push(
                    ChatPage(
                      user: chats![index].user!,
                      chatId: chats[index].id!,
                    ),
                  ),
                  child: Padding(
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
                                  chats![index].user?.name ?? '',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                if (chats[index].messages?.isNotEmpty == true)
                                  Text(
                                    chats[index].messages?[0].text ?? '',
                                    style: TextStyle(fontSize: 13),
                                  ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            if (chats[index].messages?.isNotEmpty == true)
                              Text(
                                fromNow(
                                  chats[index].messages?[0].createdAt ?? '',
                                ),
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            SizedBox(height: 3),
                            if ((chats[index].unread ?? 0) > 0)
                              Container(
                                width: 20,
                                height: 20,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: primary,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Text(
                                  '${chats[index].unread ?? 0}',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
