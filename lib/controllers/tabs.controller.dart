import 'package:get/get.dart';

class TabsController extends GetxController {
  int _index = 0;

  changeIndex(int i) {
    _index = i;
    update();
  }

  get index => _index;
}
