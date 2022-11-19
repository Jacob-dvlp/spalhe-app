import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:spalhe/components/layout/dialog/dialog.dart';
import 'package:spalhe/controllers/post_item.controller.dart';
import 'package:spalhe/controllers/posts.controller.dart';
import 'package:spalhe/controllers/profile.controller.dart';
import 'package:spalhe/models/auth.dart';
import 'package:spalhe/models/user.model.dart';
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
      OneSignal.shared.setExternalUserId(auth.user?.id.toString() ?? '');
      setLoading(false);
      Get.offAll(() => LoaderPage());
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

  deleteAccount() async {
    try {
      showDialogModal(
        title: 'he_is_sure'.tr,
        description: 'not_undo_this_action'.tr,
        confirmText: 'yes_delete_my_account'.tr,
        onConfirm: () async {
          await useMutation(DELETE_ACCOUNT_MUTATION);
          logout();
        },
      );
    } catch (e) {
      print(e);
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
          "username": user.username?.toLowerCase(),
          "biography": user.biography,
          "privated": user.privated,
          "sensitive_content": user.sensitiveContent,
        }
      });
      await getUser();
      setLoading(false);
      OnRoute.back();
    } catch (e) {
      setLoading(false);
      print(e);
    }
  }

  void updateUsername() async {
    try {
      setLoading(true);
      final user = auth.user!;
      await useMutation(UPDATE_USER_MUTATION, variables: {
        "data": {
          "name": user.name,
          "username": user.username?.toLowerCase(),
          "biography": user.biography,
          "privated": user.privated,
        }
      });
      await getUser();
      setLoading(false);
      Get.offAll(() => LoaderPage());
    } catch (e) {
      Get.snackbar(
        'Ops..',
        'Esse nome de usuário já está em uso.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade400,
        borderRadius: 4,
        colorText: Colors.white,
      );
      setLoading(false);
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
      imageQuality: 40,
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

  addCover(BuildContext c) async {
    final file = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 30,
      maxHeight: 400,
    );
    if (file != null) {
      try {
        c.loaderOverlay.show();
        dio.FormData formData = dio.FormData.fromMap({
          "files": await dio.MultipartFile.fromFile(
            file.path,
            filename: file.name,
          ),
        });
        final res = await api.post(
          '/users/upload/cover',
          data: formData,
        );
        await getUser();
        c.loaderOverlay.hide();
        update();
        return res;
      } catch (e) {
        c.loaderOverlay.hide();
        print(e);
      }
    }
    c.loaderOverlay.hide();
  }

  logout() {
    auth = AuthModel.fromJson({});
    box.write('auth', null);
    Get.delete<PostController>(force: true);
    Get.delete<AuthController>(force: true);
    Get.delete<ProfileController>(force: true);
    Get.delete<PostItemController>(force: true);
    Get.offAll(() => LoaderPage());
  }
}
