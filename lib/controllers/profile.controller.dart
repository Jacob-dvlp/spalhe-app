import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:spalhe/models/auth.dart';
import 'package:spalhe/services/api.dart';

class ProfileController extends GetxController {
  static final box = GetStorage();
  AuthModel auth = AuthModel.fromJson(box.read('auth') ?? {});
  UserModel profile = UserModel();
  int tab = 0;

  @override
  void onReady() {
    super.onReady();
    if (auth.user != null) {
      profile = auth.user!;
    }
  }

  getUser(int userId) async {
    try {
      final res = await api.get('/users/$userId');
      profile = UserModel.fromJson(res.data);
      update();
    } catch (e) {}
  }

  follow(int userId) async {
    try {
      await api.post(
        '/follows',
        data: {"user_id": userId},
      );
      getUser(userId);
    } catch (e) {
      print(e);
    }
  }

  changeIndex(int i) {
    tab = i;
    update();
  }

  reset() {
    tab = 0;
  }
}
