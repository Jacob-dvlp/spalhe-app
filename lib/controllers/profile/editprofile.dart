import 'package:spalhe/controllers/auth/auth.dart';
import 'package:spalhe/controllers/profile/profile.dart';
import 'package:spalhe/services/api.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class EditProfileController extends GetxController {
  final biographyController = TextEditingController();
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final authController = Get.put(AuthController());
  var avatar = AuthController().auth['user']['avatar'];
  var user = AuthController().auth['user'];
  final profileController = Get.put(ProfileController());

  @override
  void onReady() {
    super.onReady();
    setInititalValues();
  }

  Map<String, String> errors = {"username": "", "name": "", "biography": ""};

  var loading = false;

  void saveProfile() async {
    try {
      loading = true;
      errors = {"username": '', "name": '', "biography": ''};
      update();
      update();
      var data = {
        "name": nameController.text,
        "username": usernameController.text,
        "biography": biographyController.text,
      };
      var res = await API.put('/users', data);
      authController.changeUserData(res.data);
      Get.back();
      loading = false;
      update();
    } on dynamic catch (e) {
      loading = false;
      update();
      if (e?.response?.data['error'] != null) {
        errors['username'] = 'Nome de usuário já está em uso';
        update();
      } else {
        Get.snackbar('Desculpe-nos', 'Não foi possivel atualizar seu perfil');
      }
    }
  }

  setInititalValues() {
    biographyController.text = user['biography'];
    nameController.text = user['name'];
    usernameController.text = user['username'];
  }

  var avatarLoading = false;
  void uploadAvatar(image) {
    avatarLoading = true;
    update();
    API.upload('/upload/avatar', image).then((value) {
      authController.getMyData();
      profileController.getProfile();
      avatarLoading = false;
      update();
      Get.back();
    }).catchError((err) {
      print(err);
      Get.snackbar('Desculpe-nos', 'Não foi possivel atualizar seu perfil');
      avatarLoading = false;
      update();
    });
  }
}
