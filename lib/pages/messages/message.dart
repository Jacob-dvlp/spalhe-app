import 'package:spalhe/components/avatar/avatar.dart';
import 'package:spalhe/controllers/messages/messages.dart';
import 'package:spalhe/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({Key? key, this.user, this.id}) : super(key: key);
  final user, id;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessagesController>(
      init: MessagesController(user: user, id: id),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: ClipOval(
                  child: Avatar(
                    url: user['avatar'],
                    width: 38.0,
                    height: 38.0,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    user['name'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (user['status'] == 1)
                    const Text(
                      'Online',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                ],
              )
            ],
          ),
          // actions: [
          //   IconButton(icon: Icon(Icons.more_vert), onPressed: () => {}),
          // ],
        ),
        body: Column(
          children: [
            if (!_.messageLoading)
              Expanded(
                child: ListView(
                  reverse: true,
                  padding: const EdgeInsets.all(12),
                  children: List.generate(_.messages.length, (index) {
                    final message = _.messages[index];
                    final byMe = _.userAuth['id'].toString() ==
                        message['id_send'].toString();

                    return Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: byMe ? Alignment.topRight : Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: byMe
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: byMe
                                    ? [
                                        const Color(0xff009688),
                                        Colors.lightBlueAccent
                                      ]
                                    : [
                                        Theme.of(context)
                                            .primaryColorDark
                                            .withOpacity(0.1),
                                        Theme.of(context)
                                            .primaryColorDark
                                            .withOpacity(0.2)
                                      ],
                              ),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Text(
                              message['text'],
                              style: TextStyle(
                                color: byMe ? Colors.white : null,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 2, right: 10, left: 10, bottom: 10),
                            child: Text(
                              Utils.date(message['created_at']),
                              style: const TextStyle(fontSize: 10),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
                ),
              )
            else
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(28.0),
                  child: const Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                      ),
                    ),
                  ),
                ),
              ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight.withOpacity(0.5),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Theme.of(context)
                              .primaryColorDark
                              .withOpacity(0.08),
                          borderRadius: BorderRadius.circular(40)),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.emoji_emotions_outlined),
                            onPressed: () {
                              _.showEmojiPicker();
                              FocusScope.of(context).requestFocus(
                                FocusNode(),
                              );
                            },
                          ),
                          Expanded(
                            child: TextField(
                              controller: _.textController,
                              keyboardType: TextInputType.text,
                              onTap: _.hideEmojiPicker,
                              decoration: const InputDecoration(
                                hintText: 'Inserir mensagem',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 10,
                                ),
                              ),
                            ),
                          ),
                          // IconButton(
                          //   icon: Icon(FeatherIcons.paperclip),
                          //   onPressed: () => {},
                          // ),
                          IconButton(
                            icon: const Icon(Icons.send_rounded),
                            onPressed: () => _.sendMessage(user['id']),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
