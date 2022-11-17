import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_gif_picker/modal_gif_picker.dart';
import 'package:spalhe/constants/pubnub.dart';
import 'package:spalhe/controllers/auth.controller.dart';
import 'package:spalhe/controllers/chat.controller.dart';
import 'package:spalhe/controllers/upload.controller.dart';
import 'package:spalhe/models/chat_message.model.dart';
import 'package:spalhe/services/gql/hooks.dart';
import 'package:spalhe/services/gql/queries/chat.dart';

class MessagesController extends GetxController {
  static final box = GetStorage();

  List<Messages> messages = [];
  final TextEditingController textController = TextEditingController();
  final pubController = PubNubController();
  final authController = Get.find<AuthController>();
  final _chatController = Get.find<ChatController>();
  final picker = ImagePicker();

  bool isOnline = false;

  @override
  void onReady() async {
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

  addMsgOrUpdate(Messages msg) {
    final index = messages.indexWhere((element) => element.id == msg.id);
    if (index == -1) {
      messages.add(msg);
    } else {
      messages[index] = msg;
    }
    update();
  }

  getMessages(chatId) async {
    final mesgs = box.read('chat:$chatId');
    if (mesgs != null) {
      mesgs.forEach((element) {
        addMsgOrUpdate(element);
      });
    }

    final channel = pubController.pubnub.channel('chat:$chatId');
    final history = await channel.messages();
    await history.fetch();

    history.messages.forEach((element) {
      addMsgOrUpdate(Messages.fromJson(element.content));
      box.write('chat:$chatId', messages);
      update();
    });

    final subscription = pubController.pubnub.subscribe(channels: {
      'chat:$chatId',
    });
    subscription.messages.listen((msg) {
      addMsgOrUpdate(Messages.fromJson(msg.content));
      box.write('chat:$chatId', messages);
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
        requestFullMetadata: false,
      );

      final res = await UploadController().upload(value!);

      pubController.pubnub.publish('chat:$chatId', {
        'id': DateTime.now().toString(),
        'message': "",
        'created_at': DateTime.now().toIso8601String(),
        'user': user?.toJson(),
        'user_id': user?.id,
        'files': Files(
          url: res?.url,
          type: res?.type,
        ).toJson(),
      });

      useMutation(SEND_MESSAGE_MUTATION, variables: {
        'chat_id': chatId,
        'message': 'enviou um arquivo',
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

      if (gif != null) {
        pubController.pubnub.publish('chat:$chatId', {
          'id': DateTime.now().toString(),
          'message': "",
          'created_at': DateTime.now().toIso8601String(),
          'user': user?.toJson(),
          'user_id': user?.id,
          'gif': gif.toJson(),
        });

        useMutation(SEND_MESSAGE_MUTATION, variables: {
          'chat_id': chatId,
          'message': 'enviou um gif',
        });
      }
    } catch (e) {
      print(e);
    }
  }

  bool isLoadingDelete = false;
  deleteChat(chatId) async {
    try {
      isLoadingDelete = true;
      update();
      final channel = pubController.pubnub.channel('chat:$chatId');
      final history = await channel.messages();
      await history.delete();
      await useMutation(DELETE_CHAT_MUTATION, variables: {
        'chat_id': chatId,
      });
      await _chatController.getChats();
      isLoadingDelete = false;
      update();
    } catch (e) {
      isLoadingDelete = false;
      update();
      print(e);
    }
  }

  setViewedMessages(chatId) async {
    try {
      await useMutation(SET_VIEWED_MESSAGES, variables: {
        'chat_id': chatId,
      });
      _chatController.getChats();
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
