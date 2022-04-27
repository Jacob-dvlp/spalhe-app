import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spalhe/controllers/auth.controller.dart';
import 'package:spalhe/pages/auth/login.dart';
import 'package:spalhe/pages/home/home.dart';

class LoaderPage extends StatelessWidget {
  const LoaderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (auth) {
        if (auth.isAuth) {
          return HomePage();
        }
        return LoginPage();
      },
    );
  }
}
