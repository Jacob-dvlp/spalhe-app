import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_gif_picker/modal_gif_picker.dart';
import 'package:spalhe/constants/pubnub.dart';
import 'package:spalhe/controllers/auth.controller.dart';
import 'package:spalhe/models/chat_message.model.dart';
import 'package:spalhe/services/gql/hooks.dart';
import 'package:spalhe/services/gql/queries/chat.dart';

class MessagesController extends GetxController {
  List<Messages> messages = [];
  final TextEditingController textController = TextEditingController();
  final pubController = PubNubController();
  final authController = Get.find<AuthController>();
  final picker = ImagePicker();

  bool isOnline = false;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getUserOnline(chatId) async {
    final user = authController.auth.user;
    var result = await pubController.pubnub.hereNow(channels: {
      'chat:$chatId',
    });
    if (result.channels.values.isNotEmpty == true) {
      result.channels.values.forEach((element) {
        if (element.uuids.isNotEmpty == true) {
          element.uuids.entries.forEach((occ) {
            if (occ.key != '${user?.id}') {
              isOnline = true;
              update();
            }
          });
        }
      });
    }
  }

  getMessages(chatId) async {
    final channel = pubController.pubnub.channel('chat:$chatId');
    final history = await channel.messages();
    await history.fetch();

    history.messages.forEach((element) {
      messages.add(Messages.fromJson(element.content));
      update();
    });

    final subscription = pubController.pubnub.subscribe(channels: {
      'chat:$chatId',
    });
    subscription.messages.listen((msg) {
      messages.add(Messages.fromJson(msg.content));
      update();
      getUserOnline(chatId);
    });

    getUserOnline(chatId);
  }

  sendMessage(String chatId, String message) async {
    try {
      final user = authController.auth.user;
      pubController.pubnub.publish('chat:$chatId', {
        'id': DateTime.now().toString(),
        'message': message,
        'created_at': DateTime.now().toIso8601String(),
        'user': user?.toJson(),
        'user_id': user?.id,
      });

      useMutation(SEND_MESSAGE_MUTATION, variables: {
        'chat_id': chatId,
        'message': message,
      });
    } catch (e) {
      print(e);
    }
  }

  sendFile(chatId) async {
    try {
      final user = authController.auth.user;
      final value = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 500,
        maxHeight: 500,
        imageQuality: 30,
        requestFullMetadata: false,
      );

      final bytes = await value?.readAsBytes();
      final base64 = base64Encode(bytes!);

      pubController.pubnub.publish('chat:$chatId', {
        'id': DateTime.now().toString(),
        'message': "",
        'created_at': DateTime.now().toIso8601String(),
        'user': user?.toJson(),
        'user_id': user?.id,
        'files': Files(
          url: base64,
          type: value?.path.split('.').last,
        ).toJson(),
      });
    } catch (e) {
      print(e);
    }
  }

  sendGiphy(chatId) async {
    try {
      final user = authController.auth.user;
      final gif = await ModalGifPicker.pickModalSheetGif(
        apiKey: 'DscnjJkxGlQ9MydyYiaI8h716Z8xBcIt',
        context: Get.context!,
        rating: GiphyRating.g,
        sticker: true,
        backDropColor: Colors.black,
        crossAxisCount: 3,
        childAspectRatio: 1.2,
        topDragColor: Colors.white.withOpacity(0.2),
        previewType: GiphyPreviewType.previewWebp,
      );

      pubController.pubnub.publish('chat:$chatId', {
        'id': DateTime.now().toString(),
        'message': "",
        'created_at': DateTime.now().toIso8601String(),
        'user': user?.toJson(),
        'user_id': user?.id,
        'gif': gif?.toJson(),
      });
    } catch (e) {
      print(e);
    }
  }

  deleteChat(chatId) async {
    try {
      final channel = pubController.pubnub.channel('chat:$chatId');
      final history = await channel.messages();
      await history.delete();
      useMutation(DELETE_CHAT_MUTATION, variables: {
        'chat_id': chatId,
      });
    } catch (e) {
      print(e);
    }
  }

  setViewedMessages(chatId) async {
    try {
      final user = authController.auth.user;
      pubController.pubnub.publish('viewd_chat:$chatId', {
        'id': DateTime.now().toString(),
        'created_at': DateTime.now().toIso8601String(),
        'user_id': user?.id,
      });
    } catch (e) {
      print(e);
    }
  }
}
