import 'dart:convert';

import 'package:floor/floor.dart';

@DatabaseView('''
SELECT a.id, a.name, a.dateTime, a.description, 
(SELECT AVG(value) FROM approach_points INNER JOIN point ON id = pointId where approachId = a.id AND pointType = 's') as skill,
(SELECT AVG(value) FROM approach_points INNER JOIN point ON id = pointId where approachId = a.id AND pointType = 'a') as attraction,
(SELECT AVG(value) FROM approach_points INNER JOIN point ON id = pointId where approachId = a.id AND pointType = 'r') as result
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