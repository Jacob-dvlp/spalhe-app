import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:spalhe/components/gradient_button.dart';
import 'package:spalhe/controllers/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsernamePage extends StatelessWidget {
  const UsernamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (_) => Scaffold(
        body: SafeArea(
          child: Form(
            key: _.formUsername,
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 4),
                const Text('Só mais um passo.'),
                const Text(
                  'Complete sua conta.',
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _.usernameController,
                  keyboardType: TextInputType.text,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    labelText: 'Nome de usuário',
                    filled: true,
                    prefixIcon: Icon(
                      FeatherIcons.atSign,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    'Escolher um nome de usuário é um passo importante, pois é por meio dele que as pessoas procurarão por você.',
                    style: TextStyle(
                      fontSize: 12,
                      color:
                          Theme.of(context).primaryColorDark.withOpacity(0.5),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                GradientButton(
                  disabled: _.usernameLoading,
                  loading: _.usernameLoading,
                  onPress: _.setUserName,
                  text: 'CRIAR CONTA',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
