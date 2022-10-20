import 'package:flutter/material.dart';

const primary = Colors.amber;

class ColorLight {
  ColorLight._();

  static get primary => primary;
  static get secondary => primary.withOpacity(0.5);
  static get background => Color(0xffe6ecf0);
  static get textColor => Colors.grey.shade800;
  static get inverse => Colors.black;
}

class ColorDark {
  ColorDark._();

  static get primary => primary;
  static get secondary => primary.withOpacity(0.5);
  static get background => Colors.black;
  static get textColor => Colors.white;
  static get inverse => Colors.white;
}
