import 'package:flutter/material.dart';

class ColorManager {
  static const Color primary = Color(0xFF242A32);

  static const Color blue = Color(0xFF0296E5);
  static const Color green = Color(0xFF16D864);

  static const Color darkGrey = Color(0xFF232323);

  static const Color lightGrey = Color(0xFF67686D);
  static const Color lightestGrey = Color(0xff92929D);

  static const Color red = Color(0xFFD81616);

  static const Color orange = Color(0xFFFF8700);

  static const Color transparent = Color.fromARGB(0, 255, 255, 255);
  static const Color white = Color(0xFFEBEBEF);
  static const Color black = Color(0xFF000000);

  static const Color textColor = white;
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF$hexColorString";
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
