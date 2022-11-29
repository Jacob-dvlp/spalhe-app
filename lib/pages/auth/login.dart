import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:spalhe/components/form/input/input.dart';
import 'package:spalhe/components/layout/button/button.dart';
import 'package:spalhe/components/layout/list_view_wraper/list_view.dart';
import 'package:spalhe/controllers/auth.controller.dart';
import 'package:spalhe/controllers/social_login.controller.dart';
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
    final socialLoginController = SocialLoginController();

    return Scaffold(
      appBar: AppBar(elevation: 0),
      backgroundColor: Theme.of(context).cardColor,
      body: SafeArea(
        child: ListViewWraper(
          padding: EdgeInsets.all(24),
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 50, top: 0),
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
                  Text(
                    'OU',
                    style: TextStyle(
                      color:
                          Theme.of(context).primaryColorDark.withOpacity(0.8),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton(
                      child: Row(
                        children: [
                          Icon(FontAwesomeIcons.google),
                          SizedBox(width: 20),
                          Expanded(
                            child: Text(
                              'entrar com google',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(width: 30),
                        ],
                      ),
                      onPressed: () => socialLoginController.signInWithGoogle(),
                    ),
                  ),
                  SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton(
                      child: Row(
                        children: [
                          Icon(FontAwesomeIcons.facebook),
                          SizedBox(width: 20),
                          Expanded(
                            child: Text(
                              'entrar com facebook',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(width: 30),
                        ],
                      ),
                      onPressed: () => OnRoute.push(SinginPage()),
                    ),
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
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: TextButton(
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
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
