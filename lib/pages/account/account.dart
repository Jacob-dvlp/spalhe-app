import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:spalhe/components/layout/list_view_wraper/list_view.dart';
import 'package:spalhe/controllers/auth.controller.dart';
import 'package:spalhe/controllers/settings.controller.dart';
import 'package:spalhe/pages/account/pages/liked_posts/liked_posts.dart';
import 'package:spalhe/theme/colors.dart';

class AccountPage extends StatelessWidget {
  AccountPage({Key? key}) : super(key: key) {
    getAvailable();
  }

  getAvailable() async {
    final bool available = await InAppPurchase.instance.isAvailable();
    print({available});
    if (!available) {}
  }

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
            body: ListViewWraper(
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
                  onTap: () => Get.to(() => LikedPostsPage()),
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