import 'package:get/get.dart';
import 'package:spalhe/models/chat.model.dart';
import 'package:spalhe/services/gql/hooks.dart';
import 'package:spalhe/services/gql/queries/chat.dart';

class ChatController extends GetxController {
  ChatModel chats = ChatModel();

  @override
  void onReady() {
    super.onReady();
    getChats();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getChats() async {
    try {
      final res = await useQuery(GET_CHATS_QUERY);
      chats = ChatModel.fromJson(res.data!);
      update();
    } catch (e) {
      print(e);
    }
  }
}
