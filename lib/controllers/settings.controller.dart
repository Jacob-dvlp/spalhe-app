import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';

class SettingsController extends GetxController {
  static final box = GetStorage();
  bool themeDark = box.read('theme') == 'dark' ? true : false;

  void changeTheme(color) {
    if (color == 'light') {
      themeDark = false;
      Get.changeThemeMode(ThemeMode.light);
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ));
    } else {
      themeDark = true;
      Get.changeThemeMode(ThemeMode.dark);
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.grey[900],
        statusBarIconBrightness: Brightness.light,
      ));
    }
    box.write('theme', color);
    update();
  }
}
