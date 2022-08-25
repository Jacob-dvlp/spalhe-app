import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spalhe/models/auth.dart';
import 'package:spalhe/models/user.model.dart';
import 'package:spalhe/pages/auth/login.dart';
import 'package:spalhe/pages/loader/loader.dart';
import 'package:spalhe/services/api.dart';
import 'package:spalhe/services/gql/hooks.dart';
import 'package:spalhe/services/gql/queries/auth.dart';
import 'package:spalhe/services/gql/queries/user.dart';
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
      final res = await useQuery(GET_PROFILE);
      auth.user = UserModel.fromJson(res.data?['getProfile']);
      box.write('auth', auth.toJson());
      update();
    } catch (e) {
      print(e);
    }
  }

  Future<void> login() async {
    try {
      setLoading(true);
      final res = await useMutation(
        LOGIN_MUTATION,
        variables: {
          "data": {
            "email": loginData['email'],
            "password": loginData['password'],
          }
        },
      );
      box.write('auth', res.data?['login']);
      auth = AuthModel.fromJson(res.data?['login']);
      setLoading(false);
      OnRoute.pushOff(LoaderPage());
    } catch (e) {
      print(e);
      Get.snackbar(
        'Ops..',
        'Seus dados parecem incorretos.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade400,
        borderRadius: 4,
        colorText: Colors.white,
      );
      setLoading(false);
    }
  }

  setValue(key, value) {
    final userData = auth.user!.toJson();
    userData[key] = value;
    auth.user = UserModel.fromJson(userData);
    box.write('auth', auth.toJson());
    update();
  }

  setLoading(bool value) {
    loading = value;
    update();
  }

  void updateUser() async {
    try {
      setLoading(true);
      final user = auth.user!;
      await useMutation(UPDATE_USER_MUTATION, variables: {
        "data": {
          "name": user.name,
          "username": user.username,
          "biography": user.biography,
          "privated": user.privated,
        }
      });
      await getUser();
      update();
      setLoading(false);
      Get.snackbar(
        'Sucesso',
        'Seus dados foram atualizados.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade400,
        borderRadius: 4,
        colorText: Colors.white,
        duration: Duration(seconds: 1),
      );
    } catch (e) {
      setLoading(false);
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
      setLoading(true);
      await useMutation(CREATE_USER_MUTATION, variables: {
        "data": registerData,
      });
      loginData = registerData;
      await login();
      setLoading(false);
    } catch (e) {
      print(e);
      setLoading(false);
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
    Get.offAll(() => LoginPage());
  }
}
