import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum PointType {
  skill,
  attraction,
  difficulty,
  result,
}

class PointTypeDataLayer {
  static final String skill = 'skill';
  static final String attraction = 'attraction';
  static final String result = 'result';
}

PointType getPointTypeWithString(String str) {
  PointType pointType;
  switch (str) {
    case 'skill':
      pointType = PointType.skill;
      break;
    case 'attraction':
      pointType = PointType.attraction;
      break;
    case 'difficulty':
      pointType = PointType.difficulty;
      break;
    case 'result':
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
    case PointType.difficulty:
      iconData = FontAwesomeIcons.snowflake;
      break;
  }

  return iconData;
}
