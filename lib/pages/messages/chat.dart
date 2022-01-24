import 'package:spalhe/components/avatar/avatar.dart';
import 'package:spalhe/controllers/messages/chat.dart';
import 'package:spalhe/pages/messages/message.dart';
import 'package:spalhe/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
      init: ChatController(),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Mensagens'),
          centerTitle: false,
        ),
        body: ListView(
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorDark.withOpacity(0.08),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: const [
                  IconButton(icon: Icon(Icons.search), onPressed: null),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        filled: false,
                        hintText: 'Pesquisar por nome',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: List.generate(
                _.chats.length,
                (index) {
                  final chat = _.chats[index];

                  final String quantity =
                      (chat['__meta__']['messages_count']).toString();

                  final Map user = chat['user_one']['id'] == _.user['id']
                      ? chat['user_two']
                      : chat['user_one'];

                  final isMesage = chat['messages'] != null
                      ? chat['messages']['view'] == 0 &&
                          chat['messages']['id_send'] != _.user['id']
                      : false;

                  return TextButton(
                    onPressed: () => Get.to(
                      MessagePage(user: user, id: chat['id']),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Avatar(
                              url: user['avatar'],
                              width: 48.0,
                              height: 48.0,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 4),
                                    child: Text(
                                      user['name'],
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .primaryColorDark
                                            .withOpacity(isMesage ? 1 : 0.9),
                                      ),
                                    ),
                                  ),
                                  if (chat['messages'] != null)
                                    Text(
                                      chat['messages']['text'],
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Theme.of(context)
                                            .primaryColorDark
                                            .withOpacity(isMesage ? 1 : 0.7),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          if (chat['messages'] != null)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  Utils.date(chat['messages']['created_at']),
                                  style: const TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                                if (isMesage && quantity != "0")
                                  Container(
                                    margin: const EdgeInsets.only(top: 2),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4, vertical: 2),
                                    alignment: Alignment.center,
                                    child: Text(
                                      quantity,
                                      style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xff009688),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                              ],
                            )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
