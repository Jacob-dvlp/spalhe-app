import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:spalhe/controllers/auth.controller.dart';
import 'package:spalhe/models/auth.dart';
import 'package:spalhe/services/api.dart';

class ProfileController extends GetxController {
  int tab = 0;
  static final box = GetStorage();
  final auth = Get.put(AuthController());
  UserModel profile = UserModel();

  @override
  void onReady() {
    super.onReady();
  }

  getUser(int userId) async {
    try {
      final res = await api.get('/users/$userId');
      profile = UserModel.fromJson(res.data);
      update();
    } catch (e) {}
  }

  changeIndex(int i) {
    tab = i;
    update();
  }
}
