import 'package:flutter/material.dart';

const primary = Color(0xff009688);

class ColorLight {
  ColorLight._();

  static get primary => const Color(0xff009688);
  static get secondary => primary.withOpacity(0.5);
  static get background => Colors.grey.shade200;
  static get white => Colors.white;
  static get textColor => Colors.grey.shade800;
  static get inverse => Colors.black;
}

class ColorDark {
  ColorDark._();

  static get primary => const Color(0xff009688);
  static get secondary => primary.withOpacity(0.5);
  static get background => Colors.black54;
  static get textColor => Colors.white;
  static get inverse => Colors.white;
}
