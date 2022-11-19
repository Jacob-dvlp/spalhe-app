import 'package:get/get.dart';
import 'package:spalhe/components/form/input/input.dart';
import 'package:spalhe/components/layout/button/button.dart';
import 'package:flutter/material.dart';
import 'package:spalhe/components/layout/list_view_wraper/list_view.dart';
import 'package:spalhe/controllers/auth.controller.dart';
import 'package:spalhe/theme/colors.dart';
import 'package:spalhe/utils/routes.dart';
import 'package:url_launcher/url_launcher.dart';
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
      backgroundColor: Theme.of(context).cardColor,
      body: SafeArea(
        child: Form(
          key: formKey,
          child: ListViewWraper(
            padding: EdgeInsets.all(20),
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 10),
              Row(
                children: [
                  Text('have_account_message'.tr),
                  InkWell(
                    onTap: () => OnRoute.back(),
                    child: Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Text(
                        'enter_my_account'.tr,
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
                'sign up'.tr,
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              Input(
                label: 'your_name'.tr,
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
                label: 'your_best_email'.tr,
                onSaved: (v) => setData('email', (v ?? '')?.toLowerCase()),
                initialValue: data['email'],
                prefixIcon: Icon(
                  Icons.email_outlined,
                ),
                validator: Validatorless.multiple([
                  Validatorless.required('email_required'.tr),
                  Validatorless.email('email_is_not_valid'.tr)
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
                  Validatorless.required('password_required'.tr),
                  Validatorless.min(6, 'password_too_short'.tr),
                ]),
              ),
              SizedBox(height: 30),
              Center(
                child: Column(
                  children: [
                    Text('accept_policy_message'.tr),
                    GestureDetector(
                      onTap: () {
                        launchUrl(Uri.parse('https://spalhe.com/policy'));
                      },
                      child: Text(
                        'privacy_policies'.tr,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Button(
                title: 'signup'.tr,
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
