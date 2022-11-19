import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spalhe/controllers/settings.controller.dart';

class LangPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
        init: SettingsController(),
        builder: (settingController) {
          return Scaffold(
            appBar: AppBar(
              title: Text('language'.tr),
            ),
            body: ListView(
              children: [
                ListTile(
                  onTap: () {
                    settingController.changeLocale(
                      Locale('pt', 'BR'),
                    );
                  },
                  leading: settingController.locale.toString() == 'pt_BR'
                      ? Icon(Icons.check)
                      : Container(width: 10),
                  title: Text('🇧🇷 Português Brasil'),
                ),
                SizedBox(height: 2),
                ListTile(
                  onTap: () {
                    settingController.changeLocale(
                      Locale('en', 'US'),
                    );
                  },
                  leading: settingController.locale.toString() == 'en_US'
                      ? Icon(Icons.check)
                      : Container(width: 10),
                  title: Text('🇺🇸 English'),
                ),
              ],
            ),
          );
        });
  }
}
