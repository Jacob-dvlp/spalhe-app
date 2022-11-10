import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';
import 'package:spalhe/theme/colors.dart';

class SettingsController extends GetxController {
  static final box = GetStorage();
  bool themeDark = box.read('theme') == 'dark' ? true : false;

  void changeTheme(String color) {
    if (color == 'light') {
      themeDark = false;
      Get.changeThemeMode(ThemeMode.light);
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ));
    } else {
      themeDark = true;
      Get.changeThemeMode(ThemeMode.dark);
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: ColorDark.cardColor,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: ColorDark.cardColor,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ));
    }
    box.write('theme', color);
    update();
  }
}
