import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:spalhe/components/avatar/avatar.dart';
import 'package:spalhe/components/forms/input/input.dart';
import 'package:spalhe/controllers/profile/editprofile.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(
      init: EditProfileController(),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Editar perfil'),
          actions: [
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: _.loading ? null : _.saveProfile,
            ),
          ],
        ),
        backgroundColor: Theme.of(context).primaryColorLight,
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Column(
              children: [
                Avatar(url: _.avatar, width: 120.0, height: 120.0),
                const SizedBox(height: 5),
                TextButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.image),
                      SizedBox(width: 10),
                      Text('Selecionar imagem'),
                    ],
                  ),
                  onPressed: () async {
                    final picker = ImagePicker();
                    final pickedFile =
                        await picker.pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      _.uploadAvatar(pickedFile);
                    }
                  },
                ),
                const SizedBox(height: 30),
                Input(
                  initialValue: _.user?['name'] ?? '',
                  prefixIcon: const Icon(
                    Icons.person_outline,
                  ),
                  hint: 'Nome',
                ),
                const SizedBox(height: 15),
                Input(
                  initialValue: _.user?['username'] ?? '',
                  prefixIcon: const Icon(
                    FeatherIcons.atSign,
                    size: 20,
                  ),
                  hint: 'Nome de usuário',
                ),
                const SizedBox(height: 15),
                Input(
                  initialValue: _.user?['biography'] ?? '',
                  hint: 'Biografia',
                  prefixIcon: const Icon(
                    FeatherIcons.alignLeft,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
