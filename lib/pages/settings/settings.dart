import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spalhe/controllers/auth.controller.dart';
import 'package:spalhe/controllers/settings.controller.dart';
import 'package:spalhe/theme/colors.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return GetBuilder<SettingsController>(
        init: SettingsController(),
        builder: (settingsController) {
          return Scaffold(
            appBar: AppBar(
              title: Text('minha conta'),
            ),
            body: ListView(
              padding: EdgeInsets.symmetric(vertical: 20),
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      CupertinoSwitch(
                        activeColor: primary,
                        value: settingsController.themeDark,
                        onChanged: (value) {
                          settingsController.changeTheme(
                            !value ? 'light' : 'dark',
                          );
                        },
                      ),
                      SizedBox(width: 10),
                      Text(
                        'modo escuro',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ListTile(
                  leading: Icon(Icons.favorite_border),
                  title: Text('publicações que eu curti'),
                ),
                SizedBox(height: 2),
                ListTile(
                  leading: Icon(Icons.bookmark_border_rounded),
                  title: Text('publicações salvas'),
                ),
                SizedBox(height: 2),
                ListTile(
                  leading: Icon(Icons.security_rounded),
                  title: Text('dados e privacidade'),
                ),
                SizedBox(height: 2),
                ListTile(
                  leading: Icon(Icons.email_outlined),
                  title: Text('email e telefone'),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    authController.logout();
                  },
                  child: Text('sair da minha conta'),
                )
              ],
            ),
          );
        });
  }
}
