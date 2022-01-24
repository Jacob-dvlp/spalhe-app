import 'package:spalhe/services/api.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  List users = [];

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getSearch(text) async {
    try {
      var res = await API.get('/search/$text');
      users = res.data;
      update();
    } catch (e) {
      print(e);
    }
  }
}
