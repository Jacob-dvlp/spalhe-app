import 'package:spalhe/services/api.dart';
import 'package:get/get.dart';

class LikeController extends GetxController {
  List likes = [];
  final id;
  LikeController({this.id});

  @override
  void onReady() {
    super.onReady();
    getLikes();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getLikes() async {
    try {
      var res = await API.get('/likes/$id');
      likes = res.data;
      print(likes);
      update();
    } catch (e) {
      Get.snackbar('Erro', 'Não foi possivel carregar as curtidas');
    }
  }
}
