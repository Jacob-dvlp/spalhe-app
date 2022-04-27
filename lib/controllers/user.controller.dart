import 'package:get/get.dart';
import 'package:spalhe/controllers/auth.controller.dart';
import 'package:spalhe/services/api.dart';

class UserController extends GetxController {
  final _authController = Get.put(AuthController());

  bool loading = false;

  Map registerData = {"name": '', "email": '', "password": ''};
  void register() async {
    try {
      loading = true;
      update();
      await api.post('/user', data: registerData);
      _authController.loginData = registerData;
      _authController.login();
    } catch (e) {
      loading = false;
      update();
      print(e);
    }
  }
}
