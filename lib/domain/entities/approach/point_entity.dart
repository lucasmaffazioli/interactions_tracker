import 'dart:convert';

import 'package:cold_app/core/enums/PointType.dart';
import 'package:cold_app/presentation/common/constants.dart';
import 'package:flutter/foundation.dart';

class PointEntity {
  final int id;
  final String name;
  // final int value;
  final PointType pointType;
  final String item1;
  final String item2;
  final String item3;
  final String item4;
  final String item5;

  PointEntity({
    @required this.id,
    @required this.name,
    // @required this.value,
    @required this.pointType,
    @required this.item1,
    @required this.item2,
    @required this.item3,
    @required this.item4,
    @required this.item5,
  }) {
    if (id == null) throw ArgumentError('Error, id must not be null!');
    if (name == null) throw ArgumentError('Error, name must not be null!');
    // if (value == null) throw ArgumentError('Error, valuemust not be null!');
    // if (value < Constants.minPoints || value > Constants.maxPoints)
    // throw ArgumentError('Error!, value must be ${Constants.minPoints}-${Constants.maxPoints}');
    if (item1 == null || item1 == '') throw ArgumentError('Error, item must not be null!');
    if (item2 == null || item2 == '') throw ArgumentError('Error, item must not be null!');
    if (item3 == null || item3 == '') throw ArgumentError('Error, item must not be null!');
    if (item4 == null || item4 == '') throw ArgumentError('Error, item must not be null!');
    if (item5 == null || item5 == '') throw ArgumentError('Error, item must not be null!');
  }

  String toJson() {
    return json.encode({
      'id': id.toString(),
      'name': name,
      // 'value': value.toString(),
      'pointType': pointType.toString(),
      'item1': item1,
      'item2': item2,
      'item3': item3,
      'item4': item4,
      'item5': item5,
    });
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        // 'value': value,
        'pointType': pointType.toString(),
      };

  PointEntity.fromMap(Map map)
      : this.id = map['id'],
        this.name = map['name'],
        // this.value = map['value'],
        this.pointType = getPointTypeFromCompleteString(map['pointType']),
        this.item1 = map['item'],
        this.item2 = map['item'],
        this.item3 = map['item'],
        this.item4 = map['item'],
        this.item5 = map['item'];

  //   PointEntity.fromPointModel(PointMod map)
  // : this.id = map['id'],
  //   this.name = map['name'],
  //   // this.value = map['value'],
  //   this.pointType = getPointTypeFromCompleteString(map['pointType']),
  //   this.item1 = map['item'],
  //   this.item2 = map['item'],
  //   this.item3 = map['item'],
  //   this.item4 = map['item'],
  //   this.item5 = map['item'];
}
