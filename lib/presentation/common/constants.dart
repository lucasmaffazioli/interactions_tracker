import 'package:flutter/material.dart';

class Constants {
  static const Color mainTextColor = Color(0xFF535354);
  static const Color background = Color(0xFFF2F4F9);
  static const Color chartLineBackground = Color(0xffDADCE4);
  static const Color accent = Color(0xFF143EE9);
  static const Color accent2 = Color(0xFFF5438DC);
  static const Color accent3 = Color(0xFFFF5800);
  static const Color red = Color(0xFFE91414);
  static const Color accentDisabled = Color(0xFF535354);
  static const TextStyle textH1 = TextStyle(
    fontFamily: 'MPlusRounded',
    fontWeight: FontWeight.w900,
    fontSize: 26,
    color: Constants.mainTextColor,
  );
  static const TextStyle textWhite = TextStyle(
    fontFamily: 'MPlusRounded',
    fontWeight: FontWeight.w900,
    fontSize: 26,
    color: Colors.white,
  );
  static const double borderRadiusCards = 20;
  static const double borderRadiusSmall = 4;
  static const Offset shadowOrientation = Offset(0, 6);
  static const BoxShadow boxShadow = BoxShadow(
      offset: Constants.shadowOrientation, color: Colors.black45, spreadRadius: 0.0, blurRadius: 6);
  static const Color borderColor = Color.fromARGB(36, 0, 0, 0);
  static const int minPoints = 1;
  static const int maxPoints = 5;
}
