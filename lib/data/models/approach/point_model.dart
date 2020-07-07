import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:floor/floor.dart';

@Entity(tableName: 'point', indices: [
  Index(
    value: ['name'],
    unique: true,
  ),
])
class PointModel {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String name;
  final String pointType;

  PointModel({
    @required this.id,
    @required this.name,
    @required this.pointType,
  }) {
    // if (id == null) throw ArgumentError('Error!');
    if (name == null) throw ArgumentError('Error!');
    if (pointType == null) throw ArgumentError('Error!');
  }

  String toJson() {
    return json.encode({
      'id': id.toString(),
      'name': name,
      'pointType': pointType.toString(),
    });
  }
}
