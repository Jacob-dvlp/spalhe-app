import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:spalhe/controllers/tabs.controller.dart';

class BottomNavigationComponent extends StatelessWidget {
  const BottomNavigationComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TabsController>(builder: (tab) {
      return BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 22,
        type: BottomNavigationBarType.fixed,
        currentIndex: tab.index,
        onTap: tab.changeIndex,
        elevation: 10,
        unselectedLabelStyle: TextStyle(fontSize: 0),
        selectedLabelStyle: TextStyle(fontSize: 0),
        items: [
          BottomNavigationBarItem(
            label: '',
            icon: Icon(FeatherIcons.home),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(FeatherIcons.search),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(FeatherIcons.messageCircle),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(FeatherIcons.bell),
          ),
        ],
      );
    });
  }
}
