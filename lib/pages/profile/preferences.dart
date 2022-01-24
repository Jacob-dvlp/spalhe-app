import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:spalhe/controllers/auth/auth.dart';
import 'package:spalhe/pages/auth/forgot.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PreferencesPage extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  PreferencesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Preferências'),
          elevation: 0,
        ),
        backgroundColor: Theme.of(context).primaryColorLight,
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () => authController.changeTheme('light'),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    child: Text(
                      'Light',
                      style: TextStyle(
                        color: Get.isDarkMode
                            ? Theme.of(context)
                                .primaryColorDark
                                .withOpacity(0.3)
                            : Theme.of(context).primaryColorDark,
                      ),
                    ),
                  ),
                ),
                Text(
                  '/',
                  style: TextStyle(
                    color: Theme.of(context).primaryColorDark.withOpacity(0.3),
                  ),
                ),
                InkWell(
                  onTap: () => authController.changeTheme('dark'),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    child: Text(
                      'Dark',
                      style: TextStyle(
                        color: !Get.isDarkMode
                            ? Theme.of(context)
                                .primaryColorDark
                                .withOpacity(0.3)
                            : Theme.of(context).primaryColorDark,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Column(
              children: [
                TextButton(
                  onPressed: () => Get.to(ForgotPage()),
                  child: Text('Recuperar senha'),
                ),
                const SizedBox(height: 14),
                TextButton(
                  onPressed: () => {},
                  child: const Text('Alterar email'),
                ),
                const SizedBox(height: 14),
                TextButton(
                  onPressed: () => {},
                  child: const Text('Privacidade'),
                ),
                const SizedBox(height: 14),
                TextButton(
                  style: TextButton.styleFrom(primary: Colors.red[400]),
                  onPressed: () => authController.getLogout(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(FeatherIcons.logOut),
                      SizedBox(width: 10),
                      Text('Sair dessa conta'),
                    ],
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
