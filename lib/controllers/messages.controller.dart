import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spalhe/models/chat_message.model.dart';
import 'package:spalhe/services/gql/hooks.dart';
import 'package:spalhe/services/gql/queries/chat.dart';

class MessagesController extends GetxController {
  ChatMessageModel? chat_messages;
  List<Messages> get messages => (chat_messages?.getChatMessages?.data ?? []);
  final TextEditingController textController = TextEditingController();

  String? chatId;

  setChatId(id) {
    chatId = id;
    update();
  }

  @override
  void onReady() {
    messageAddSubscription(chatId);
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  messageAddSubscription(chatId) async {
    final sub = await useSubscription(
      MESSAGE_ADD_SUBSCRIPTION,
      variables: {"chat_id": chatId},
    );

    sub.listen((message) {
      if (message.data?['messageAdded']?['id'] != null) {
        chat_messages?.getChatMessages?.data?.add(
          Messages.fromJson(message.data?['messageAdded']),
        );
        update();
      }
    });
  }

  sendMessage(String chatId, String message) async {
    try {
      await useMutation(SEND_MESSAGE_MUTATION, variables: {
        'chat_id': chatId,
        'message': message,
      });
      // await getChatMessages(chatId);
    } catch (e) {
      print(e);
    }
  }

  getChatMessages(String id) async {
    try {
      final res = await useQuery(GET_CHAT_MESSAGE_QUERY, variables: {
        'chat_id': id,
      });
      chat_messages = ChatMessageModel.fromJson(res.data!);
      update();
    } catch (e) {
      print(e);
    }
  }
}
