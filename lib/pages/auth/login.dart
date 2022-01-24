import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:spalhe/components/gradient_button.dart';
import 'package:spalhe/controllers/auth/auth.dart';
import 'package:spalhe/pages/auth/singin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'forgot.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).size.height / 6;

    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (_) => Scaffold(
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () => _.changeTheme('light'),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Light',
                        style: TextStyle(
                          color: Get.isDarkMode
                              ? Theme.of(context)
                                  .primaryColorDark
                                  .withOpacity(0.3)
                              : Theme.of(context).primaryColorDark,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    '/',
                    style: TextStyle(
                      color:
                          Theme.of(context).primaryColorDark.withOpacity(0.3),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _.changeTheme('dark'),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Dark',
                        style: TextStyle(
                          color: !Get.isDarkMode
                              ? Theme.of(context)
                                  .primaryColorDark
                                  .withOpacity(0.3)
                              : Theme.of(context).primaryColorDark,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Form(
                key: _.formLogin,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 40, top: top),
                      child: SizedBox(
                        width: 90,
                        height: 90,
                        child: Image.asset('assets/icon.png'),
                      ),
                    ),
                    TextFormField(
                      controller: _.emailController,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        filled: true,
                        prefixIcon: Icon(
                          Icons.email_outlined,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _.passwordController,
                      keyboardType: TextInputType.text,
                      obscureText: _.showPass,
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        filled: true,
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                        ),
                        suffixIcon: GestureDetector(
                          child: Icon(
                            _.showPass ? FeatherIcons.eyeOff : FeatherIcons.eye,
                            size: 20,
                          ),
                          onTap: _.showPassword,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
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
                          const SizedBox(width: 10),
                          InkWell(
                            child: const Text(
                              'Recuperar a conta',
                              style: TextStyle(
                                color: Color(0xff009688),
                              ),
                            ),
                            onTap: () => Get.to(ForgotPage()),
                          ),
                        ],
                      ),
                    ),
                    GradientButton(
                      loading: _.loginLoading,
                      disabled: _.loginLoading,
                      onPress: _.getLogin,
                      text: 'ENTRAR',
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
            padding: const EdgeInsets.all(12),
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
                  child: const Text(
                    'Criar minha conta',
                    style: TextStyle(
                      color: Color(0xff009688),
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  onPressed: () => Get.to(SinginPage()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
