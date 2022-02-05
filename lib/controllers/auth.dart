import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:spalhe/models/auth.dart';
import 'package:spalhe/pages/home/home.dart';
import 'package:spalhe/services/api.dart';

class AuthController extends GetxController {
  static final box = GetStorage();
  AuthModel auth = AuthModel.fromJson(box.read('auth') ?? {});
  get isAuth => auth.token != null;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void changeUserData(key, value) {
    final data = auth.toJson();
    data['user'][key] = value;
    auth = AuthModel.fromJson(data);
    update();
  }

  void getLogout() {
    Get.offAllNamed('/login');
    box.write('auth', null);
    update();
  }

  bool loading = false;
  Map loginData = {"email": '', "password": ''};

  Future<void> login() async {
    try {
      loading = true;
      update();
      print(loginData);
      final res = await api.post('/auth', data: loginData);
      box.write('auth', res.data);
      auth = AuthModel.fromJson(res.data);
      Get.offAll(HomePage());
      update();
    } catch (e) {
      loading = false;
      update();
      print(e);
    }
  }

  Map registerData = {"name": '', "email": '', "password": ''};
  void register() async {
    try {
      loading = true;
      update();
      await api.post('/user', data: registerData);
      loginData = registerData;
      loading = false;
      await login();
    } catch (e) {
      loading = false;
      update();
      print(e);
    }
  }
}
