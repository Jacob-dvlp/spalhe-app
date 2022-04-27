import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> customRoute = GlobalKey<NavigatorState>();

class OnRoute {
  static Future push(Widget page) async {
    await customRoute.currentState?.push(
      MaterialPageRoute(builder: (BuildContext context) => page),
    );
  }

  static back() {
    customRoute.currentState?.pop();
  }

  static Future replace(Widget page) async {
    await customRoute.currentState?.pushReplacement(
      MaterialPageRoute(builder: (context) => page),
    );
  }

  static Future pushOff(Widget page) async {
    await customRoute.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => page),
      (route) => false,
    );
  }

  static Future pushOffNamed(String page) async {
    await customRoute.currentState?.pushNamedAndRemoveUntil(
      page,
      (route) => false,
    );
  }
}
