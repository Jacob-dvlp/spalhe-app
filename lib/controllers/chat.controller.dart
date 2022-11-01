import 'package:get/get.dart';
import 'package:spalhe/controllers/auth.controller.dart';
import 'package:spalhe/models/chat.model.dart';
import 'package:spalhe/pages/chat/chat.dart';
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

  createChat(userId) async {
    try {
      final myId = authController.auth.user!.id;
      final res = await useMutation(CREATE_CHAT_MUTATION, variables: {
        "data": {
          'user_ids': [userId, myId],
        }
      });

      Get.to(
        () => ChatPage(
          chat: GetChats.fromJson(
            res.data?['createChat'],
          ),
        ),
      );
    } catch (e) {
      print(e);
    }
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
      final res = await useQuery(GET_CHATS_QUERY);
      chats = ChatModel.fromJson(res.data!);
      update();
    } catch (e) {
      print(e);
    }
  }
}
