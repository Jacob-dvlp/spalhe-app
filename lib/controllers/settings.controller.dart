import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';

class SettingsController extends GetxController {
  static final box = GetStorage();

  void changeTheme(color) {
    box.write('theme', color);
    if (color == 'light') {
      Get.changeTheme(ThemeData.light());
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ));
    } else {
      Get.changeTheme(ThemeData.dark());
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.grey[900],
        statusBarIconBrightness: Brightness.light,
      ));
    }
  }
}