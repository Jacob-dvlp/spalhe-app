import 'dart:convert';
import 'package:spalhe/pages/auth/username.dart';
import 'package:spalhe/pages/home/home.dart';
import 'package:spalhe/services/api.dart';
import 'package:spalhe/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  static final box = GetStorage();
  var auth = box.read('auth');
  bool isAuth = box.read('auth') != null;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  bool showPass = true;

  // forms
  final formLogin = GlobalKey<FormState>();
  final formSingup = GlobalKey<FormState>();
  GlobalKey<FormState> formUsername = GlobalKey<FormState>();

  @override
  void onReady() {
    super.onReady();
    getMyData();
    updateGToken();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void changeUserData(data) {
    auth['user'] = data;
    box.write('auth', auth);
    update();
  }

  void getMyData() async {
    try {
      if (isAuth && auth['user']['id'] != null) {
        final res = await API.get('/users/${auth['user']['id']}');
        changeUserData(res.data);
        update();
      }
    } catch (e) {
      print(e);
    }
  }

  void updateGToken() async {}

  void changeTheme(color) {
    box.write('theme', color);
    if (color == 'light') {
      Get.changeThemeMode(ThemeMode.light);
    } else {
      Get.changeThemeMode(ThemeMode.dark);
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.grey[900],
        statusBarIconBrightness: Brightness.light,
      ));
    }
  }

  void getLogout() {
    Get.offAllNamed('/login');
    box.write('auth', null);
    auth = null;
    update();
  }

  var loginLoading = false;
  var validationLogin = {"email": false, "password": false};

  Future<void> getLogin() async {
    if (formLogin.currentState!.validate()) {
      try {
        formLogin.currentState!.save();
        loginLoading = true;
        update();
        var res = await API.post(
          '/login',
          json.encode({
            "email": emailController.text,
            "password": passwordController.text
          }),
        );
        auth = res.data;
        update();
        box.write('auth', res.data);
        loginLoading = false;
        update();
        Get.offAll(HomePage());
      } on dynamic catch (err) {
        loginLoading = false;
        update();
        if (err is List) {
          // erros de validação
        } else {
          if (err['status'] == 401) {
            Get.snackbar(
              err['title'] ?? '',
              err['message'] ?? '',
              backgroundColor: const Color(0xffff6b81),
              colorText: Colors.white,
              snackStyle: SnackStyle.FLOATING,
              margin: const EdgeInsets.all(14),
            );
          }
        }
      }
    }
  }

  var registerLoading = false;
  void getRegister() async {
    if (formSingup.currentState!.validate()) {
      try {
        formSingup.currentState?.save();
        registerLoading = true;
        update();
        var res = await API.post('/register', {
          "email": emailController.text,
          "password": passwordController.text,
          "name": nameController.text,
          "username": Utils().getRandomString(15)
        });
        auth = res.data;
        registerLoading = false;
        update();
        Get.to(const UsernamePage());
      } catch (err) {
        print(err);
        registerLoading = false;
        update();
        Get.snackbar(
          'Erro ao criar conta, verifique os dados',
          'Encontramos um problema ao tentar conectar você',
          backgroundColor: Color(0xffff6b81),
          colorText: Colors.white,
          margin: const EdgeInsets.all(14),
        );
      }
    }
  }

  var usernameLoading = false;
  void setUserName() async {
    if (!!formUsername.currentState!.validate()) {
      try {
        usernameLoading = true;
        update();
        var text = usernameController.text;
        await API.put('/users/change/username', {
          "username": text,
        });
        await getLogin();
        usernameLoading = false;
        update();
      } catch (err) {
        usernameLoading = false;
        update();
        print(err);
        Get.snackbar(
          'Desculpe-nos',
          'Parece que o nome de usuário já existe',
        );
      }
    }
  }

  void showPassword() {
    showPass = !showPass;
    update();
  }
}
