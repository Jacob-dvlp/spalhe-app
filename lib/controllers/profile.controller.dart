import 'dart:ffi';

import 'package:get/get.dart';

class ProfileController extends GetxController {
  int tab = 0;

  changeIndex(int i) {
    tab = i;
    update();
  }
}
