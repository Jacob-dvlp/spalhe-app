import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:spalhe/controllers/auth.controller.dart';

class PolicyPage extends StatelessWidget {
  const PolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('dados e privacidade'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(FeatherIcons.userX),
            title: Text('usuários bloqueadas'),
          ),
          SizedBox(height: 4),
          ListTile(
            leading: Icon(FeatherIcons.alertTriangle),
            title: Text('publicações denunciadas'),
          ),
          SizedBox(height: 4),
          ListTile(
            onTap: () => authController.deleteAccount(),
            leading: Icon(FeatherIcons.trash),
            title: Text('apagar minha conta'),
          ),
          SizedBox(height: 4),
        ],
      ),
    );
  }
}
