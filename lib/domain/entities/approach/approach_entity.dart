import 'dart:convert';

import 'package:cold_app/domain/entities/approach/point_entity.dart';
import 'package:flutter/foundation.dart';

class ApproachEntity {
  final int id;
  final DateTime dateTime;
  final String name;
  final String description;
  final String notes;
  final List<PointEntity> points;

  ApproachEntity({
    @required this.id,
    @required this.dateTime,
    @required this.name,
    @required this.description,
    this.notes,
    @required this.points,
  }) {
    // if (id == null) throw ArgumentError('Error!');
    if (dateTime == null) throw ArgumentError('Error!');
    if (name == null) throw ArgumentError('Error!');
    if (description == null) throw ArgumentError('Error!');
  }

  String toJson() {
    return json.encode({
      'id': id.toString(),
      'dateTime': dateTime.toIso8601String(),
      'name': name,
      'description': description,
      'notes': notes,
      'points': points.map((e) => e.toJson()).toList(),
    });
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'dateTime': dateTime.toIso8601String(),
        'name': name,
        'description': description,
        'notes': notes,
        'points': points.map((e) => e.toMap()).toList(),
      };

  factory ApproachEntity.fromMap(Map<String, dynamic> map) {
    List<PointEntity> points = [];
    List pointsMap = map['points'];

    pointsMap.forEach((e) {
      print('PointEntity.fromMap(e).toJson()');
      print(PointEntity.fromMap(e).toJson());
      points.add(PointEntity.fromMap(e));
    });

    return new ApproachEntity(
      id: map['id'],
      dateTime: DateTime.parse(map['dateTime']),
      name: map['name'],
      description: map['description'],
      notes: map['notes'],
      points: points,
    );
  }

  // : this.id = map['id'],
  //   this.dateTime = DateTime.parse(map['dateTime']),
  //   this.name = map['name'],
  //   this.description = map['description'],
  //   this.notes = map['notes'],
  //   // this.points = map['points']
  //   //     .map((e) => PointEntity.fromMap(e))
  //   //     .toList(); //List[PointEntity.fromMap(map['points'])];
  //   this.points = map['points'].map<List<PointEntity>>((e) {
  //     print(e);
  //     final a = PointEntity.fromMap(e);
  //     return a;
  //   }).toList(); //List[PointEntity.fromMap(map['points'])];

  // this.points = _convertMapPoints(map['points']); //List[PointEntity.fromMap(map['points'])];

  // List<PointEntity> _convertMapPoints(Map map) {
  //   List<PointEntity> returnList;
  // }
}
