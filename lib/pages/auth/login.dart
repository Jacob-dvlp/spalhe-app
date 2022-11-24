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
import 'package:url_launcher/url_launcher.dart';
import 'package:validatorless/validatorless.dart';
import 'forgot.dart';

class LoginPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final auth = Get.put(AuthController());
    final top = MediaQuery.of(context).size.height / 7.5 - 80;

    return Scaffold(
      appBar: AppBar(elevation: 0),
      backgroundColor: Theme.of(context).cardColor,
      body: SafeArea(
        child: ListViewWraper(
          padding: EdgeInsets.all(20),
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 50, top: top),
                    child: SizedBox(
                      width: 160,
                      height: 90,
                      child: SvgPicture.asset(Get.isDarkMode
                          ? 'assets/logo.svg'
                          : 'assets/logo_white.svg'),
                    ),
                  ),
                  Input(
                    autofocus: false,
                    hint: 'email',
                    label: 'email',
                    onSaved: (v) => auth.loginData['email'] = v,
                    initialValue: auth.loginData['email'],
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icon(Icons.email_outlined),
                    validator: Validatorless.multiple([
                      Validatorless.required('email_required'.tr),
                      Validatorless.email('email_is_not_valid'.tr)
                    ]),
                  ),
                  SizedBox(height: 10),
                  Input(
                    autofocus: false,
                    onSaved: (v) => auth.loginData['password'] = v,
                    initialValue: auth.loginData['password'],
                    label: 'password'.tr,
                    obscureText: true,
                    prefixIcon: Icon(Icons.lock_outline),
                    validator: Validatorless.multiple([
                      Validatorless.required('password_required'.tr),
                    ]),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'forgot_password_message'.tr,
                          style: TextStyle(
                              color: Theme.of(context).primaryColorDark),
                        ),
                        SizedBox(width: 10),
                        InkWell(
                          child: Text(
                            'forgot_password_button'.tr,
                            style: TextStyle(
                              color: primary,
                            ),
                          ),
                          onTap: () => OnRoute.push(ForgotPage()),
                        ),
                      ],
                    ),
                  ),
                  Button(
                    loading: false,
                    title: 'signin'.tr,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        auth.login();
                      }
                    },
                  ),
                  SizedBox(height: 40),
                  Column(
                    children: [
                      Text(
                        'dont_have_account'.tr,
                        style: TextStyle(
                          color: Theme.of(context)
                              .primaryColorDark
                              .withOpacity(0.8),
                        ),
                      ),
                      TextButton(
                        child: Text(
                          'signup'.tr,
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
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
          child: SizedBox(
        height: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Spalhe © 2022',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 6),
            GestureDetector(
              onTap: () {
                launchUrl(Uri.parse('https://spalhe.com/policy'));
              },
              child: Text(
                'privacy_policies'.tr,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: primary,
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
