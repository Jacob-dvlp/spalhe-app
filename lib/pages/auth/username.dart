import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spalhe/components/form/input/input.dart';
import 'package:spalhe/components/layout/list_view_wraper/list_view.dart';
import 'package:spalhe/controllers/auth.controller.dart';
import 'package:validatorless/validatorless.dart';

class UsernamePage extends StatelessWidget {
  UsernamePage({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();

  final auth = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: ListViewWraper(
            padding: EdgeInsets.all(20),
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 4),
              Text(
                'Só mais um passo.',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              ),
              Text(
                'Seu nome de usuário',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 14),
              Input(
                label: 'Nome de usuário',
                prefixIcon: Icon(
                  FeatherIcons.atSign,
                  size: 20,
                ),
                onSaved: (v) => auth.setValue('username', v),
                validator: Validatorless.multiple([
                  Validatorless.required('nome de usuario obrigatório'),
                  Validatorless.regex(
                    RegExp(
                      r'^[a-z0-9](_(?!(\.|_))|\.(?!(_|\.))|[a-z0-9]){3,18}[a-z0-9]$',
                      caseSensitive: false,
                    ),
                    'nome de usuário inválido',
                  ),
                ]),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(elevation: 0),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      auth.updateUser();
                    }
                  },
                  child: Text('Salvar'),
                ),
              ),
              SizedBox(height: 14),
            ],
          ),
        ),
      ),
    );
  }
}
