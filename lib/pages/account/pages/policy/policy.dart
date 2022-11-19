import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:spalhe/controllers/auth.controller.dart';
import 'package:spalhe/pages/account/pages/policy/pages/blocked_users.dart';
import 'package:spalhe/theme/colors.dart';

class PolicyPage extends StatelessWidget {
  const PolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('data_and_privacy'.tr),
      ),
      body: ListView(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(
              left: 20,
            ),
            child: Row(
              children: [
                GetBuilder<AuthController>(
                  init: AuthController(),
                  builder: (controller) {
                    return CupertinoSwitch(
                      activeColor: primary,
                      value: controller.auth.user?.sensitiveContent ?? false,
                      onChanged: (value) {
                        controller.setValue('sensitive_content', value);
                        controller.updateUser();
                      },
                    );
                  },
                ),
                SizedBox(width: 10),
                Text(
                  'filter_sensitive_content'.tr,
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
            onTap: () => Get.to(() => BlockedUsersPage()),
            leading: Icon(FeatherIcons.userX),
            title: Text('blocked_users'.tr),
          ),
          SizedBox(height: 4),
          ListTile(
            leading: Icon(FeatherIcons.alertTriangle),
            title: Text('reported_posts'.tr),
          ),
          SizedBox(height: 4),
          ListTile(
            onTap: () => authController.deleteAccount(),
            leading: Icon(FeatherIcons.trash),
            title: Text('delete_my_account'.tr),
          ),
          SizedBox(height: 4),
        ],
      ),
    );
  }
}
