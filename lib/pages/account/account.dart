import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spalhe/components/layout/list_view_wraper/list_view.dart';
import 'package:spalhe/controllers/auth.controller.dart';
import 'package:spalhe/controllers/settings.controller.dart';
import 'package:spalhe/pages/account/pages/liked_posts/liked_posts.dart';
import 'package:spalhe/pages/account/pages/policy/policy.dart';
import 'package:spalhe/pages/account/pages/saved_posts/saved_posts.dart';
import 'package:spalhe/theme/colors.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return GetBuilder<SettingsController>(
        init: SettingsController(),
        builder: (settingsController) {
          return Scaffold(
            appBar: AppBar(
              title: Text('my_account'.tr),
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
                        'dark_mode'.tr,
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
                  title: Text('publications_i_liked'.tr),
                ),
                SizedBox(height: 2),
                ListTile(
                  onTap: () => Get.to(() => SavedPostsPage()),
                  leading: Icon(Icons.bookmark_border_rounded),
                  title: Text('saved_posts'.tr),
                ),
                SizedBox(height: 2),
                ListTile(
                  onTap: () => Get.to(() => PolicyPage()),
                  leading: Icon(Icons.security_rounded),
                  title: Text('data_and_privacy'.tr),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    authController.logout();
                  },
                  child: Text('log_out_of_my_account'.tr),
                )
              ],
            ),
          );
        });
  }
}
