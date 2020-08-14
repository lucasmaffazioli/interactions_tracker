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
  final String item1;
  final String item2;
  final String item3;
  final String item4;
  final String item5;

  PointModel({
    @required this.id,
    @required this.name,
    @required this.pointType,
    @required this.item1,
    @required this.item2,
    @required this.item3,
    @required this.item4,
    @required this.item5,
  }) {
    // if (id == null) throw ArgumentError('Error!');
    if (name == null || name.trim() == '') throw ArgumentError('Error!');
    if (pointType == null) throw ArgumentError('Error!');
    if (item1 == null || item1 == '') throw ArgumentError('Error! item1 must not be null!');
    if (item2 == null || item2 == '') throw ArgumentError('Error! item2 must not be null!');
    if (item3 == null || item3 == '') throw ArgumentError('Error! item3 must not be null!');
    if (item4 == null || item4 == '') throw ArgumentError('Error! item4 must not be null!');
    if (item5 == null || item5 == '') throw ArgumentError('Error! item5 must not be null!');
  }

  String toJson() {
    return json.encode({
      'id': id.toString(),
      'name': name,
      'pointType': pointType.toString(),
    });
  }
}
