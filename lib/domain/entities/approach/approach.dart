import 'package:flutter/foundation.dart';
import 'pointer.dart';

class Approach {
  final String uid;
  final DateTime dateTime;
  final String name;
  final String description;
  final String notes;
  final List<Pointer> points;

  Approach({
    @required this.uid,
    @required this.dateTime,
    @required this.name,
    @required this.description,
    @required this.notes,
    @required this.points,
  }) {
    if (uid == null) throw ArgumentError('Error!');
    if (dateTime == null) throw ArgumentError('Error!');
    if (name == null) throw ArgumentError('Error!');
    if (description == null) throw ArgumentError('Error!');
    if (notes == null) throw ArgumentError('Error!');
  }

  factory Approach.fromMap(String _uid, Map<String, dynamic> map) {
    // print(map);
    // Pointer _pointer = Pointer.fromMap(['points'][0]);
    return Approach(
      uid: _uid,
      dateTime: DateTime.parse(map['dateTime']),
      name: map['name'],
      description: map['description'],
      notes: map['notes'],
      points: List.castFrom(map['points']).map((e) => Pointer.fromMap(e)).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    List<String> pointsMap = [];
    points.forEach((Pointer e) {
      pointsMap.add(e.toMap().toString());
    });

    return {
      'dateTime': dateTime.toIso8601String(),
      'name': name,
      'description': description,
      'notes': notes,
      'points': pointsMap,
    };
  }
}
