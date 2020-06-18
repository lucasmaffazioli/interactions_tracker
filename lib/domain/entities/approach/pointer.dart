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

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'value': value,
      'pointType': pointType,
    };
  }

  factory Pointer.fromJson(Map<String, dynamic> json) {
    return Pointer(
      name: json['name'],
      value: json['value'],
      pointType: json['pointType'],
    );
  }
}
