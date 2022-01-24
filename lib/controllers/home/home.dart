import 'package:get/get.dart';

class HomeController extends GetxController {
  var tabIndex = 0;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void changeTab(index) {
    tabIndex = index;
    update();
  }
}
