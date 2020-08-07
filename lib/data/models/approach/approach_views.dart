import 'dart:convert';

import 'package:floor/floor.dart';

@DatabaseView('''
SELECT a.id, a.name, a.dateTime, a.description, 
(SELECT AVG(value) FROM approach_points INNER JOIN point ON id = pointId where approachId = a.id AND pointType = 'PointType.difficulty') as difficulty,
(SELECT AVG(value) FROM approach_points INNER JOIN point ON id = pointId where approachId = a.id AND pointType = 'PointType.skill') as skill,
(SELECT AVG(value) FROM approach_points INNER JOIN point ON id = pointId where approachId = a.id AND pointType = 'PointType.attraction') as attraction,
(SELECT AVG(value) FROM approach_points INNER JOIN point ON id = pointId where approachId = a.id AND pointType = 'PointType.result') as result
FROM approach a
ORDER BY a.dateTime DESC
''', viewName: 'approach_summary_view')
//
class ApproachSummaryView {
  final int id;
  final String name;
  final String dateTime;
  final String description;
  final double difficulty;
  final double skill;
  final double attraction;
  final double result;

  ApproachSummaryView(
    this.id,
    this.name,
    this.dateTime,
    this.description,
    this.difficulty,
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
      'difficulty': skill.toString(),
      'skill': skill.toString(),
      'attraction': attraction.toString(),
      'result': result.toString(),
    });
  }
}

@DatabaseView('''
SELECT ap.approachId, ap.pointId, p.name AS pointName, ap.value AS pointValue, p.pointType, p.item1, p.item2, p.item3, p.item4, p.item5 
FROM approach_points ap
INNER JOIN point p ON p.id = ap.pointId 
ORDER BY p.pointType
''', viewName: 'approach_points_view')
//
class ApproachPointsView {
  final int approachId;
  final int pointId;
  final String pointName;
  final int pointValue;
  final String pointType;
  final String item1;
  final String item2;
  final String item3;
  final String item4;
  final String item5;

  ApproachPointsView({
    this.approachId,
    this.pointId,
    this.pointName,
    this.pointValue,
    this.pointType,
    this.item1,
    this.item2,
    this.item3,
    this.item4,
    this.item5,
  });

  String toJson() {
    return json.encode({
      'approachId': approachId.toString(),
      'pointId': pointId.toString(),
      'pointName': pointName,
      'pointValue': pointValue.toString(),
      'pointType': pointType,
      'item1': item1,
      'item2': item2,
      'item3': item3,
      'item4': item4,
      'item5': item5,
    });
  }
}

// @DatabaseView('''
//   SELECT ap.pointId, p.name AS pointName, AVG(ap.value) AS pointAvg, p.pointType
//     FROM approach a
//     INNER JOIN approach_points ap ON a.id = ap.approachId
//     INNER JOIN point p ON p.id = ap.pointId
//     GROUP BY ap.pointId, pointName, pointType
//     ORDER BY p.pointType
//   ''', viewName: 'approach_dashboard_view')
// class ApproachesDashboardDataView {
//   final int pointId;
//   final double pointAvg;
//   final String pointName;
//   final String pointType;

//   ApproachesDashboardDataView({
//     this.pointId,
//     this.pointName,
//     this.pointAvg,
//     this.pointType,
//   });
// }
