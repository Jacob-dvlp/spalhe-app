import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spalhe/models/chat.model.dart';
import 'package:spalhe/models/chat_message.model.dart';
import 'package:spalhe/services/gql/hooks.dart';
import 'package:spalhe/services/gql/queries/chat.dart';

class ChatController extends GetxController {
  ChatModel chats = ChatModel();
  ChatMessageModel chat_messages = ChatMessageModel();
  List<GetChatMessages> get messages => chat_messages.getChatMessages ?? [];
  final TextEditingController textController = TextEditingController();
  int chatId = 0;

  @override
  void onReady() {
    super.onReady();
    getChats();
  }

  @override
  void onClose() {
    super.onClose();
  }

  subscritionChat() async {
    final sub = await useSubscription(CHAT_MESSAGE_SUBSCRIPTION, variables: {
      'chat_id': chatId,
    });

    sub.listen((message) {
      if (message.data?['chatAdded']?['messages']?[0] != null) {
        chat_messages.getChatMessages?.add(
          GetChatMessages.fromJson(message.data?['chatAdded']?['messages']?[0]),
        );
        update();
      }
    });
  }

  sendMessage(int userId, String message) async {
    try {
      await useMutation(SEND_MESSAGE_MUTATION, variables: {
        "user_id": userId,
        "message": message,
      });
    } catch (e) {}
  }

  getChats() async {
    try {
      final res = await useQuery(GET_CHATS_QUERY);
      chats = ChatModel.fromJson(res.data!);
      update();
    } catch (e) {}
  }

  getChatMessages(int id) async {
    try {
      chatId = id;
      final res = await useQuery(GET_CHAT_MESSAGE_QUERY, variables: {
        "chat_id": chatId,
      });
      chat_messages = ChatMessageModel.fromJson(res.data ?? {});
      subscritionChat();
      update();
    } catch (e) {
      print(e);
    }
  }
}
