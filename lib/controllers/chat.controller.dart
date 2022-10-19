import 'package:get/get.dart';
import 'package:spalhe/controllers/auth.controller.dart';
import 'package:spalhe/models/chat.model.dart';
import 'package:spalhe/services/gql/hooks.dart';
import 'package:spalhe/services/gql/queries/chat.dart';

class ChatController extends GetxController {
  ChatModel chats = ChatModel();
  final authController = Get.put(AuthController());

  @override
  void onReady() {
    chatAddSubscription();
    getChats();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  chatAddSubscription() async {
    try {
      final sub = await useSubscription(
        CHAT_ADD_SUBSCRIPTION,
        variables: {
          "user_id": authController.auth.user!.id,
        },
      );

      sub.listen((message) {
        getChats();
      });
    } catch (e) {
      print(e);
    }
  }

  getChats() async {
    try {
      print('Atualizou os Chats');
      final res = await useQuery(GET_CHATS_QUERY);
      chats = ChatModel.fromJson(res.data!);
      update();
    } catch (e) {
      print(e);
    }
  }
}
