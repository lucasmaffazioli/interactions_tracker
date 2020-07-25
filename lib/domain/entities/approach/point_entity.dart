import 'dart:convert';

import 'package:cold_app/core/enums/PointType.dart';
import 'package:flutter/foundation.dart';

class PointEntity {
  final int id;
  final String name;
  final int value;
  final PointType pointType;

  PointEntity({
    @required this.id,
    @required this.name,
    @required this.value,
    @required this.pointType,
  }) {
    if (id == null) throw ArgumentError('Error, id must not be null!');
    if (name == null) throw ArgumentError('Error, name must not be null!');
    if (value == null) throw ArgumentError('Error, valuemust not be null!');
    if (value < 0 || value > 10) throw ArgumentError('Error!, value must be 0-10');
  }

  String toJson() {
    return json.encode({
      'id': id.toString(),
      'name': name,
      'value': value.toString(),
      'pointType': pointType.toString(),
    });
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'value': value,
        'pointType': pointType.toString(),
      };

  PointEntity.fromMap(Map map)
      : this.id = map['id'],
        this.name = map['name'],
        this.value = map['value'],
        this.pointType = getPointTypeFromCompleteString(map['pointType']);
}
