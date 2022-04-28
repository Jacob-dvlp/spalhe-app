import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spalhe/components/form/input/input.dart';
import 'package:spalhe/components/layout/image/image.dart';
import 'package:spalhe/controllers/auth.controller.dart';
import 'package:spalhe/theme/colors.dart';
import 'package:validatorless/validatorless.dart';

class EditProfilePage extends StatelessWidget {
  EditProfilePage({Key? key}) : super(key: key);

  final _auth = Get.put(AuthController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final user = _auth.auth.user!;

    return Scaffold(
      appBar: AppBar(
        title: Text('editar perfil'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Form(
            key: formKey,
            child: Column(
              children: [
                Stack(
                  children: [
                    GetBuilder<AuthController>(
                      builder: (_auth) {
                        return Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: ImageNetwork(
                              src: _auth.auth.user?.avatar ?? '',
                              width: 120,
                              height: 120,
                            ),
                          ),
                        );
                      },
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () => _auth.addAvatar(),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Icon(
                            Icons.add_a_photo_outlined,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 30),
                Input(
                  label: 'nome',
                  onSaved: (v) => _auth.setValue('name', v),
                  initialValue: user.name,
                  validator: Validatorless.multiple([
                    Validatorless.required('nome obrigatório'),
                    Validatorless.min(10, 'nome inválido'),
                  ]),
                ),
                SizedBox(height: 14),
                Input(
                  onSaved: (v) => _auth.setValue('username', v),
                  label: 'nome de usuário',
                  initialValue: user.username,
                  validator: Validatorless.multiple([
                    Validatorless.required('nome de usuario obrigatório'),
                    Validatorless.min(10, 'nome de usuário inválido'),
                  ]),
                ),
                SizedBox(height: 14),
                Input(
                  onSaved: (v) => _auth.setValue('biography', v),
                  label: 'biografia',
                  initialValue: user.biography,
                  maxLines: 4,
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: Size.infinite.width,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        _auth.updateUser();
                      }
                    },
                    child: Text('salvar'),
                  ),
                ),
                InkWell(
                  onTap: () => _auth.logout(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Sair'),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
