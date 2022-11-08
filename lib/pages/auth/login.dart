import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:spalhe/components/form/input/input.dart';
import 'package:spalhe/components/layout/button/button.dart';
import 'package:spalhe/components/layout/list_view_wraper/list_view.dart';
import 'package:spalhe/controllers/auth.controller.dart';
import 'package:spalhe/pages/auth/singin.dart';
import 'package:flutter/material.dart';
import 'package:spalhe/theme/colors.dart';
import 'package:spalhe/utils/routes.dart';
import 'package:validatorless/validatorless.dart';
import 'forgot.dart';

class LoginPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final auth = Get.put(AuthController());
    final top = MediaQuery.of(context).size.height / 6;

    return Scaffold(
      body: SafeArea(
        child: ListViewWraper(
          padding: EdgeInsets.all(20),
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 40, top: top),
                    child: SizedBox(
                      width: 190,
                      height: 90,
                      child: SvgPicture.asset('assets/logo.svg'),
                    ),
                  ),
                  Input(
                    hint: 'Email',
                    label: 'Email',
                    onSaved: (v) => auth.loginData['email'] = v,
                    initialValue: auth.loginData['email'],
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icon(Icons.email_outlined),
                    validator: Validatorless.multiple([
                      Validatorless.required('Email obrigatório'),
                      Validatorless.email('Email não é válido')
                    ]),
                  ),
                  SizedBox(height: 10),
                  Input(
                    onSaved: (v) => auth.loginData['password'] = v,
                    initialValue: auth.loginData['password'],
                    label: 'Senha',
                    obscureText: true,
                    prefixIcon: Icon(Icons.lock_outline),
                    validator: Validatorless.multiple([
                      Validatorless.required('Senha obrigatória'),
                      Validatorless.min(6, 'Senha muito curta'),
                    ]),
                  ),
                  SizedBox(height: 16),
                  Button(
                    loading: false,
                    title: 'Entrar',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        auth.login();
                      }
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Esqueceu a senha?',
                          style: TextStyle(
                            color: Theme.of(context)
                                .primaryColorDark
                                .withOpacity(0.8),
                          ),
                        ),
                        SizedBox(width: 10),
                        InkWell(
                          child: Text(
                            'Recuperar a conta',
                            style: TextStyle(
                              color: primary,
                            ),
                          ),
                          onTap: () => OnRoute.push(ForgotPage()),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 120,
          padding: EdgeInsets.all(12),
          alignment: Alignment.bottomCenter,
          child: Column(
            children: [
              Text(
                'Não tem uma conta ainda?',
                style: TextStyle(
                  color: Theme.of(context).primaryColorDark.withOpacity(0.8),
                ),
              ),
              TextButton(
                child: Text(
                  'Criar minha conta',
                  style: TextStyle(
                    color: primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                onPressed: () => OnRoute.push(SinginPage()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
