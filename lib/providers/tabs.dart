import 'package:flutter/material.dart';

class TabsProvider with ChangeNotifier {
  int _index = 0;

  changeIndex(i) {
    _index = i;
    notifyListeners();
  }

  get index => _index;
}
