import 'package:spalhe/controllers/auth/auth.dart';
import 'package:spalhe/services/api.dart';

import 'package:get/get.dart';

class ChatController extends GetxController {
  List chats = [];
  var user = AuthController().auth['user'];

  @override
  void onReady() {
    super.onReady();
    getChats();
    getChatsWS();
    setOnline();
  }

  @override
  void onClose() {
    super.onClose();
  }

  String getTotal() {
    return chats
        .where((el) =>
            el['messages'] != null &&
            el['messages']['view'].toString() == '0' &&
            el['messages']['id_send'] != user['id'])
        .length
        .toString();
  }

  void clearNotifications() async {
    var list = [];
    for (var item in chats) {
      item['messages']['view'] = 1;
      list.add(item);
    }
    chats = list;
    update();
    // call api
  }

  setOnline() async {
    // var disponible = await socket.subscribe('status:${user['id']}');
  }

  void getChatsWS() async {
    // final disponible = await socket.subscribe('chat:${user['id']}');
    // disponible.on('message', (data) {
    //   var index = chats.indexWhere((el) => el['id'] == data['id']);
    //   if (index >= 0) {
    //     chats[index] = data;
    //   } else {
    //     chats.add(data);
    //   }
    //   update();
    // });
  }

  void getChats() {
    API.get('/chat').then((value) {
      chats = value.data;
      update();
    });
  }
}
