import 'package:spalhe/controllers/auth/auth.dart';
import 'package:spalhe/controllers/profile/profile.dart';
import 'package:spalhe/services/api.dart';
import 'package:get/get.dart';

class EditProfileController extends GetxController {
  final authController = Get.put(AuthController());
  final avatar = AuthController().auth['user']['avatar'];
  final user = AuthController().auth['user'];
  final profileController = Get.put(ProfileController());

  bool loading = false;

  final data = {
    "name": "",
    "username": "",
    "biography": "",
  };

  setData(key, value) {
    data[key] = value;
    update();
  }

  void saveProfile() async {
    try {
      loading = true;
      update();

      var res = await API.put('/users', data);
      authController.changeUserData(res.data);
      Get.back();
      loading = false;
      update();
    } catch (e) {
      loading = false;
      Get.snackbar('Desculpe-nos', 'Não foi possivel atualizar seu perfil');
      update();
    }
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
      Get.snackbar('Desculpe-nos', 'Não foi possivel atualizar seu perfil');
      avatarLoading = false;
      update();
    });
  }
}
