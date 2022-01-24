import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: LoadingController(),
      builder: (_) => const Scaffold(
        backgroundColor: Color(0xff009688),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class LoadingController extends GetxController {
  static final box = GetStorage();
  var auth = box.read('auth');
  var theme = box.read('theme');

  @override
  void onReady() {
    Get.changeThemeMode(theme == 'light' ? ThemeMode.light : ThemeMode.dark);
    if (auth != null) {
      Get.offAllNamed('/home');
    } else {
      Get.offAllNamed('/login');
    }
    super.onReady();
  }
}
