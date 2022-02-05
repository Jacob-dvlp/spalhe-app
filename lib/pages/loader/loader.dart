import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:spalhe/controllers/auth.dart';
import 'package:spalhe/pages/auth/login.dart';
import 'package:spalhe/pages/home/home.dart';

class LoaderPage extends StatelessWidget {
  const LoaderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AuthController>(
        init: AuthController(),
        builder: (context) {
          final isAuth = context.isAuth;
          return isAuth ? HomePage() : LoginPage();
        },
      ),
    );
  }
}
