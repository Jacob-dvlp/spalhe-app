import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:spalhe/components/gradient_button.dart';
import 'package:spalhe/controllers/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SinginPage extends StatelessWidget {
  const SinginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (_) => Scaffold(
        body: SafeArea(
          child: Form(
            key: _.formSingup,
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 4),
                Row(
                  children: [
                    const Text('Já tem uma conta?'),
                    InkWell(
                      onTap: Get.back,
                      child: const Padding(
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
                const Text(
                  'Nova conta',
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _.nameController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                    filled: true,
                    prefixIcon: Icon(
                      Icons.person_outline,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _.emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    filled: true,
                    prefixIcon: Icon(
                      Icons.email_outlined,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
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
                const SizedBox(height: 14),
                GradientButton(
                  loading: _.registerLoading,
                  disabled: _.registerLoading,
                  onPress: () => _.getRegister(),
                  text: 'PRÓXIMO',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
