import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spalhe/components/layout/list_view_wraper/list_view.dart';
import 'package:spalhe/controllers/profile.controller.dart';
import 'package:spalhe/pages/explore/components/explore_medias.dart';
import 'package:spalhe/pages/explore/components/new_users.dart';
import 'package:spalhe/pages/search/search.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.all(2),
          child: GestureDetector(
            onTap: () => Get.to(() => SearchPage()),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: Get.theme.primaryColorDark.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'pesquise pessoas',
                style: TextStyle(
                  color: Get.theme.primaryColorDark.withOpacity(0.3),
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
      body: ListViewWraper(
        children: [
          NewUsers(profileController: profileController),
          ExploreMidias(),
        ],
      ),
    );
  }
}
