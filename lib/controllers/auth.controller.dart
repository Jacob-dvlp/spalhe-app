import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spalhe/models/auth.dart';
import 'package:spalhe/pages/loader/loader.dart';
import 'package:spalhe/services/api.dart';
import 'package:spalhe/utils/routes.dart';

class AuthController extends GetxController {
  static final box = GetStorage();
  AuthModel auth = AuthModel.fromJson(box.read('auth') ?? {});
  get isAuth => auth.token != null;

  bool loading = false;
  Map loginData = {"email": '', "password": ''};

  @override
  void onReady() {
    super.onReady();
    getUser();
  }

  getUser() async {
    try {
      final res = await api.get('/users/my_profile');
      auth.user = UserModel.fromJson(res.data);
      box.write('auth', auth.toJson());
      update();
    } catch (e) {}
  }

  Future<void> login() async {
    try {
      loading = true;
      update();
      final res = await api.post('/auth', data: loginData);
      box.write('auth', res.data);
      auth = AuthModel.fromJson(res.data);
      update();
      OnRoute.pushOff(LoaderPage());
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

  setValue(key, value) {
    final userData = auth.user!.toJson();
    userData[key] = value;
    auth.user = UserModel.fromJson(userData);
    box.write('auth', auth.toJson());
    update();
  }

  void updateUser() async {
    try {
      loading = true;
      update();
      final user = auth.user!;
      await api.put('/users/update/profile', data: {
        "name": user.name,
        "username": user.username,
        "biography": user.biography,
      });
      await getUser();
      update();
    } catch (e) {
      print(e);
      loading = false;
      update();
      print(e);
    }
  }

  Map registerData = {"name": '', "email": '', "password": ''};

  void setRegisterData(key, value) {
    registerData[key] = value;
    update();
  }

  void register() async {
    try {
      print(registerData);
      loading = true;
      update();
      await api.post('/users', data: registerData);
      loginData = registerData;
      await login();
    } catch (e) {
      print(e);
      loading = false;
      update();
      print(e);
    }
  }

  final picker = ImagePicker();
  bool loadingAvatar = false;
  addAvatar() async {
    final file = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
      maxHeight: 500,
    );
    if (file != null) {
      try {
        loadingAvatar = true;
        update();
        dio.FormData formData = dio.FormData.fromMap({
          "files": await dio.MultipartFile.fromFile(
            file.path,
            filename: file.name,
          ),
        });
        final res = await api.post(
          '/users/upload/avatar',
          data: formData,
        );
        await getUser();
        loadingAvatar = false;
        update();
        return res;
      } catch (e) {
        print(e);
        loadingAvatar = false;
        update();
      }
    }
  }

  logout() {
    auth = AuthModel.fromJson({});
    box.write('auth', null);
  }
}
