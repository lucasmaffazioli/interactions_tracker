import 'dart:convert';

import 'package:floor/floor.dart';

@DatabaseView('''
SELECT a.id, a.name, a.dateTime, a.description, 
(SELECT AVG(value) FROM approach_points INNER JOIN point ON id = pointId where approachId = a.id AND pointType = 'skill') as skill,
(SELECT AVG(value) FROM approach_points INNER JOIN point ON id = pointId where approachId = a.id AND pointType = 'attraction') as attraction,
(SELECT AVG(value) FROM approach_points INNER JOIN point ON id = pointId where approachId = a.id AND pointType = 'result') as result
FROM approach a
ORDER BY a.dateTime
''', viewName: 'approachSummaryView')
//
class ApproachSummaryView {
  final int id;
  final String name;
  final String dateTime;
  final String description;
  final double skill;
  final double attraction;
  final double result;

  ApproachSummaryView(
    this.id,
    this.name,
    this.dateTime,
    this.description,
    this.skill,
    this.attraction,
    this.result,
  );

  String toJson() {
    return json.encode({
      'id': id.toString(),
      'name': name,
      'dateTime': dateTime,
      'description': description,
      'skill': skill.toString(),
      'attraction': attraction.toString(),
      'result': result.toString(),
    });
  }
}

@DatabaseView('''
SELECT ap.approachId, ap.pointId, p.name, ap.value, p.pointType from approach_points ap
INNER JOIN point p ON p.id = ap.pointId 
ORDER BY p.pointType
''', viewName: 'approachPointsView')
//
class ApproachPointsView {
  final int approachId;
  final int pointId;
  final String pointName;
  final int pointValue;
  final String pointType;

  ApproachPointsView({
    this.approachId,
    this.pointId,
    this.pointName,
    this.pointValue,
    this.pointType,
  });

  // String toJson() {
  //   return json.encode({
  //     'id': id.toString(),
  //     'name': name,
  //     'dateTime': dateTime,
  //     'description': description,
  //     'skill': skill.toString(),
  //     'attraction': attraction.toString(),
  //     'result': result.toString(),
  //   });
  // }
}
