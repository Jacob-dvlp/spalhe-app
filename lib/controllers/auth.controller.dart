import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:spalhe/models/auth.dart';
import 'package:spalhe/pages/home/home.dart';
import 'package:spalhe/services/api.dart';
import 'package:spalhe/utils/routes.dart';

class AuthController extends GetxController {
  static final box = GetStorage();
  AuthModel auth = AuthModel.fromJson(box.read('auth') ?? {});
  get isAuth => auth.token != null;

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
      OnRoute.pushOff(HomePage());
    } catch (e) {
      Get.snackbar(
        'Ops..',
        'Seus dados parecem incorretos.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade400,
        borderRadius: 4,
        colorText: Colors.white,
      );
      loading = false;
      update();
    }
  }
}
