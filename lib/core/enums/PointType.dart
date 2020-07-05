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
