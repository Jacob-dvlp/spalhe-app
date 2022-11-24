import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:spalhe/components/form/input/input.dart';
import 'package:spalhe/components/layout/image/image.dart';
import 'package:spalhe/components/layout/list_view_wraper/list_view.dart';
import 'package:spalhe/controllers/auth.controller.dart';
import 'package:spalhe/theme/colors.dart';
import 'package:validatorless/validatorless.dart';

class EditProfilePage extends StatelessWidget {
  EditProfilePage({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('edit_profile'.tr),
      ),
      body: GetBuilder<AuthController>(
        global: true,
        autoRemove: false,
        builder: (_auth) {
          final user = _auth.auth.user!;
          return ListViewWraper(
            children: [
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 200,
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: primary,
                            image: user.cover != null
                                ? DecorationImage(
                                    image: NetworkImage(user.cover ?? ''),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: 120,
                                    height: 120,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: ImageNetwork(
                                        src: _auth.auth.user?.avatar ?? '',
                                        width: 120,
                                        height: 120,
                                      ),
                                    ),
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
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        child: Icon(
                                          FeatherIcons.image,
                                          color: Colors.black,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 10,
                          top: 10,
                          child: InkWell(
                            onTap: () => _auth.addCover(context),
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: primary,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Icon(
                                FeatherIcons.image,
                                color: Colors.black,
                                size: 18,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24).copyWith(top: 5),
                      child: Column(
                        children: [
                          SizedBox(height: 30),
                          Input(
                            label: 'name'.tr,
                            onSaved: (v) => _auth.setValue('name', v),
                            initialValue: user.name,
                            validator: Validatorless.multiple([
                              Validatorless.required('required_name'.tr),
                              Validatorless.min(
                                3,
                                'name_must_be_at_least_4_char'.tr,
                              ),
                            ]),
                          ),
                          SizedBox(height: 24),
                          Input(
                            onSaved: (v) => _auth.setValue(
                              'username',
                              v?.toLowerCase(),
                            ),
                            label: 'username'.tr,
                            initialValue: user.username?.toLowerCase(),
                            validator: Validatorless.multiple([
                              Validatorless.required('required_username'.tr),
                              Validatorless.regex(
                                RegExp(
                                  r'^[a-z0-9](_(?!(\.|_))|\.(?!(_|\.))|[a-z0-9]){3,18}[a-z0-9]$',
                                  caseSensitive: false,
                                ),
                                'invalid_username'.tr,
                              ),
                            ]),
                          ),
                          SizedBox(height: 24),
                          Input(
                            onSaved: (v) => _auth.setValue('biography', v),
                            label: 'biography'.tr,
                            initialValue: user.biography,
                            maxLines: 4,
                          ),
                          SizedBox(height: 20),
                          Visibility(
                            visible: true,
                            child: Row(
                              children: [
                                CupertinoSwitch(
                                  activeColor: primary,
                                  value: user.privated == true,
                                  onChanged: (isPrivated) {
                                    _auth.setValue('privated', isPrivated);
                                  },
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'private_account'.tr,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
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
                              child: Text('save'.tr),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
