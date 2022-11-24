import 'package:flutter/material.dart';

const primary = Colors.amber;

class ColorLight {
  ColorLight._();

  static get primary => primary;
  static get secondary => primary.withOpacity(0.5);
  static get background => Color(0xFFF2F5F8);
  static get textColor => Colors.grey.shade800;
  static get inverse => Colors.black;
}

class ColorDark {
  ColorDark._();

  static get primary => primary;
  static get secondary => primary.withOpacity(0.5);
  static get background => Color(0xff151a21);
  static get textColor => Colors.white;
  static get inverse => Colors.white;
  static get cardColor => Color(0xff1b1f26);
}
