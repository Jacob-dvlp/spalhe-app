import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:spalhe/components/avatar/avatar.dart';
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
          padding: const EdgeInsets.all(10.0),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Avatar(url: _.avatar, width: 120.0, height: 120.0),
                  const SizedBox(height: 5),
                  if (!_.avatarLoading)
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
                            await picker.getImage(source: ImageSource.gallery);
                        if (pickedFile != null) {
                          _.uploadAvatar(pickedFile);
                        }
                      },
                    )
                  else
                    Container(
                      padding: const EdgeInsets.all(28.0),
                      color: Theme.of(context).primaryColorLight,
                      child: const Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _.nameController,
                    autocorrect: false,
                    autovalidateMode: AutovalidateMode.always,
                    decoration: const InputDecoration(
                      labelText: 'Nome',
                      filled: true,
                      prefixIcon: Icon(
                        Icons.person_outline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _.usernameController,
                    autocorrect: false,
                    autovalidateMode: AutovalidateMode.always,
                    decoration: InputDecoration(
                      labelText: 'Nome de usuário',
                      errorText: _.errors['username'],
                      filled: true,
                      prefixIcon: const Icon(
                        FeatherIcons.atSign,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _.biographyController,
                    minLines: 1,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      labelText: 'Sobre mim',
                      filled: true,
                      prefixIcon: Icon(
                        Icons.badge,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
