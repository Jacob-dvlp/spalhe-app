import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spalhe/components/input/input.dart';
import 'package:spalhe/controllers/auth.dart';

class UsernamePage extends StatelessWidget {
  UsernamePage({Key? key}) : super(key: key);
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
                const Input(
                  label: 'Nome de usuário',
                  prefixIcon: Icon(
                    FeatherIcons.atSign,
                    size: 20,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
