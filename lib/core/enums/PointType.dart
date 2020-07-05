import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum PointType {
  skill,
  attraction,
  result,
}

class PointTypeDataLayer {
  static final String skill = 's';
  static final String attraction = 'a';
  static final String result = 'r';
}

PointType getPointTypeWithString(String str) {
  PointType pointType;
  switch (str) {
    case 's':
      pointType = PointType.skill;
      break;
    case 'a':
      pointType = PointType.attraction;
      break;
    case 'r':
      pointType = PointType.result;
      break;
  }

  return pointType;
}

IconData getPointTypeIcon(PointType pointType) {
  IconData iconData;
  switch (pointType) {
    case PointType.skill:
      iconData = FontAwesomeIcons.pollH;
      break;
    case PointType.attraction:
      iconData = FontAwesomeIcons.solidHeart;
      break;
    case PointType.result:
      iconData = FontAwesomeIcons.medal;
      break;
  }

  return iconData;
}
