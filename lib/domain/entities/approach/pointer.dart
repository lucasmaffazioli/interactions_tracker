import 'package:flutter/foundation.dart';

enum PointType {
  skill,
  attraction,
  result,
}

class Pointer {
  final String name;
  final int value;
  final PointType pointType;

  Pointer({
    @required this.name,
    @required this.value,
    @required this.pointType,
  }) {
    if (name == null) throw ArgumentError('Error!');
    if (value == null) throw ArgumentError('Error!');
    if (value < 0 || value > 10) throw ArgumentError('Error!');
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'value': value,
      'pointType': pointType,
    };
  }

  factory Pointer.fromMap(Map<String, dynamic> map) {
    return Pointer(
      name: map['name'],
      value: map['value'],
      pointType: map['pointType'],
    );
  }
}
