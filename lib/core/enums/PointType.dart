import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum PointType {
  skill,
  attraction,
  difficulty,
  result,
}

// class PointTypeDataLayer {
//   static final String skill = 'skill';
//   static final String attraction = 'attraction';
//   static final String result = 'result';
// }

PointType getPointTypeFromString(String str) {
  PointType pointType;
  switch (str) {
    case 'PointType.skill':
      pointType = PointType.skill;
      break;
    case 'PointType.attraction':
      pointType = PointType.attraction;
      break;
    case 'PointType.difficulty':
      pointType = PointType.difficulty;
      break;
    case 'PointType.result':
      pointType = PointType.result;
      break;
  }
  // switch (str) {
  //   case 'skill':
  //     pointType = PointType.skill;
  //     break;
  //   case 'attraction':
  //     pointType = PointType.attraction;
  //     break;
  //   case 'difficulty':
  //     pointType = PointType.difficulty;
  //     break;
  //   case 'result':
  //     pointType = PointType.result;
  //     break;
  // }

  return pointType;
}

PointType getPointTypeFromCompleteString(String str) {
  PointType pointType;
  switch (str) {
    case 'PointType.skill':
      pointType = PointType.skill;
      break;
    case 'PointType.attraction':
      pointType = PointType.attraction;
      break;
    case 'PointType.difficulty':
      pointType = PointType.difficulty;
      break;
    case 'PointType.result':
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
      iconData = FontAwesomeIcons.solidDizzy;
      // iconData = FontAwesomeIcons.snowflake;
      break;
  }

  return iconData;
}
