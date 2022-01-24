import 'package:spalhe/controllers/auth/auth.dart';
import 'package:spalhe/controllers/messages/chat.dart';
import 'package:spalhe/services/api.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MessagesController extends GetxController {
  MessagesController({this.user, this.id});
  final user;
  var id;
  List messages = [];
  var userAuth = AuthController().auth['user'];

  var visibleEmojiPicker = false;
  final textController = TextEditingController();

  final ChatController chatController = Get.put(ChatController());

  @override
  void onReady() async {
    super.onReady();
    await createChat();
    getMessages();
    getMessagesWS();
    setViewMessage();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> createChat() async {
    if (id == null) {
      try {
        var value = await API.post('/chat', {"id_received": user['id']});
        id = value.data['data']['id'];
        update();
      } catch (err) {
        print(err);
      }
    }
  }

  void sendMessage(int userid) {
    if (id != null) {
      String text = textController.text;
      textController.text = '';
      API.post('/messages/$id', {
        "text": text,
        "id_received": userid,
      }).catchError((err) => print('[MESSAGES]=> ocorreu um erro ao enviar'));
    }
  }

  Future<void> getMessagesWS() async {
    // await socket.connect();
    // var disponible = await socket.subscribe('message:$id');
    // disponible.on('message', (data) {
    //   messages.insert(0, data);
    //   update();
    // });
  }

  var messageLoading = true;
  Future<void> getMessages() async {
    API.get('/messages/$id').then((value) {
      messages = value.data;
      messageLoading = false;
      update();
    }).catchError((err) => print('[MESSAGES]=> ocorreu um erro ao buscar'));
  }

  Future<void> setViewMessage() async {
    API.put('/messages/$id', {}).then((value) {
      update();
    });
    chatController.clearNotifications();
  }

  void showEmojiPicker() {
    visibleEmojiPicker = !visibleEmojiPicker;
    update();
  }

  void hideEmojiPicker() {
    visibleEmojiPicker = false;
    update();
  }

  void addEmojiInput(emoji) {
    textController.text = textController.text + emoji;
  }
}
