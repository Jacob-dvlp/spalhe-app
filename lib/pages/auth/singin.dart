import 'package:get/get.dart';
import 'package:spalhe/components/form/input/input.dart';
import 'package:spalhe/components/layout/button/button.dart';
import 'package:flutter/material.dart';
import 'package:spalhe/components/layout/dialog/dialog.dart';
import 'package:spalhe/components/layout/list_view_wraper/list_view.dart';
import 'package:spalhe/constants/terms.dart';
import 'package:spalhe/controllers/auth.controller.dart';
import 'package:spalhe/theme/colors.dart';
import 'package:spalhe/utils/routes.dart';
import 'package:validatorless/validatorless.dart';

class SinginPage extends StatelessWidget {
  SinginPage({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());
    final data = authController.registerData;
    final setData = authController.setRegisterData;

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: ListViewWraper(
            padding: EdgeInsets.all(20),
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 10),
              Row(
                children: [
                  Text('já tem uma conta?'),
                  InkWell(
                    onTap: () => OnRoute.back(),
                    child: Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Text(
                        'entar na minha conta',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                'criar uma conta',
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 54),
              Input(
                label: 'seu nome',
                onSaved: (v) => setData('name', v),
                initialValue: data['name'],
                prefixIcon: Icon(
                  Icons.person_outline,
                ),
                validator: Validatorless.multiple([
                  Validatorless.required('nome obrigatório'),
                  Validatorless.min(
                    3,
                    'nome deve ter no mínimo 4 caracteres',
                  ),
                ]),
              ),
              SizedBox(height: 14),
              Input(
                label: 'seu melhor email',
                onSaved: (v) => setData('email', v),
                initialValue: data['email'],
                prefixIcon: Icon(
                  Icons.email_outlined,
                ),
                validator: Validatorless.multiple([
                  Validatorless.required('email não pode ser vazio'),
                  Validatorless.email('email não é válido')
                ]),
              ),
              SizedBox(height: 14),
              Input(
                label: 'sua senha secreta',
                obscureText: true,
                onSaved: (v) => setData('password', v),
                initialValue: data['password'],
                prefixIcon: Icon(
                  Icons.lock_outline,
                ),
                validator: Validatorless.multiple([
                  Validatorless.required('senha obrigatória'),
                  Validatorless.min(6, 'senha muito curta'),
                ]),
              ),
              SizedBox(height: 30),
              Column(
                children: [
                  Text(
                    'ao criar sua conta, você concorda com os',
                    style: TextStyle(fontSize: 14),
                  ),
                  TextButton(
                    onPressed: () {
                      showDialogModal(
                        title: 'termos de uso e política de privacidade',
                        description: TermosDeUso,
                        onConfirm: () {},
                        cancelText: '',
                        confirmText: 'aceitar',
                      );
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                    ),
                    child: Text(
                      'termos de uso e política de privacidade',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primary,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Button(
                title: 'criar minha conta',
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    authController.register();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
