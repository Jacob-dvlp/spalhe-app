import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';
import 'package:spalhe/providers/tabs.dart';

class BottomNavigationComponent extends StatelessWidget {
  const BottomNavigationComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tabs = Provider.of<TabsProvider>(context);

    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      iconSize: 22,
      type: BottomNavigationBarType.fixed,
      currentIndex: tabs.index,
      onTap: tabs.changeIndex,
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
  }
}
