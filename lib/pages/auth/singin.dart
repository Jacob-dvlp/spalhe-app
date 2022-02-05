import 'package:spalhe/components/button/button.dart';
import 'package:spalhe/components/input/input.dart';

import 'package:spalhe/controllers/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SinginPage extends StatelessWidget {
  SinginPage({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (_) => Scaffold(
        body: SafeArea(
          child: Form(
            key: formKey,
            child: ListView(
              padding: EdgeInsets.all(20),
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 4),
                Row(
                  children: [
                    Text('Já tem uma conta?'),
                    InkWell(
                      onTap: Get.back,
                      child: Padding(
                        padding: EdgeInsets.all(6.0),
                        child: Text(
                          'Entar',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff009688),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  'Nova conta',
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 14),
                Input(
                  label: 'Nome',
                  prefixIcon: Icon(
                    Icons.person_outline,
                  ),
                ),
                SizedBox(height: 14),
                Input(
                  label: 'Email',
                  prefixIcon: Icon(
                    Icons.email_outlined,
                  ),
                ),
                SizedBox(height: 14),
                Input(
                  label: 'Senha',
                  prefixIcon: Icon(
                    Icons.lock_outline,
                  ),
                ),
                SizedBox(height: 14),
                Button(
                  title: 'Cadastrar-me',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
