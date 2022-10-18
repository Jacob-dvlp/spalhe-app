import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spalhe/models/chat.model.dart';
import 'package:spalhe/models/chat_message.model.dart';

class ChatController extends GetxController {
  ChatModel chats = ChatModel();
  ChatMessageModel? chat_messages;
  List<GetChatMessages> get messages => chat_messages?.getChatMessages ?? [];
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

  viewMessages() async {}

  subscritionMessageChat() async {}

  subscribeToView() async {}

  sendMessage(int userId, String message) async {}

  getChats() async {
    try {} catch (e) {
      print(e);
    }
  }

  getChatMessages(int id) async {}
}
