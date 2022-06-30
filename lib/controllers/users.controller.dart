import 'package:get/get.dart';
import 'package:spalhe/models/users.model.dart';
import 'package:spalhe/services/api.dart';

class UserController extends GetxController {
  UsersModel users = UsersModel();

  @override
  void onReady() {
    getUsers();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getUsers() async {
    try {
      final res = await api.get('/users');
      users = UsersModel.fromJson(res.data);
      update();
    } catch (e) {
      print(e);
    }
  }
}
