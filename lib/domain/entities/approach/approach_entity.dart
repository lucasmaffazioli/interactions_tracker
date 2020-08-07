import 'dart:convert';

import 'package:cold_app/domain/entities/approach/point_entity.dart';
import 'package:flutter/foundation.dart';

class ApproachEntity {
  final int id;
  final DateTime dateTime;
  final String name;
  final String description;
  final String notes;
  final List<ApproachPointEntity> points;

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
}

class ApproachPointEntity extends PointEntity {
  final int value;
  ApproachPointEntity({
    @required id,
    @required name,
    @required this.value,
    @required pointType,
    @required item1,
    @required item2,
    @required item3,
    @required item4,
    @required item5,
  }) : super(
          id: id,
          name: name,
          pointType: pointType,
          item1: item1,
          item2: item2,
          item3: item3,
          item4: item4,
          item5: item5,
        );
}
