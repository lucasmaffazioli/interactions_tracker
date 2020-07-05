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
    if (id == null) throw ArgumentError('Error!');
    if (name == null) throw ArgumentError('Error!');
    if (value == null) throw ArgumentError('Error!');
    if (value < 0 || value > 10) throw ArgumentError('Error!');
  }

  String toJson() {
    return json.encode({
      'id': id.toString(),
      'name': name,
      'value': value.toString(),
      'pointType': pointType.toString(),
    });
  }
}
