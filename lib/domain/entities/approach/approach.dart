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

  factory Approach.fromJson(String _uid, Map<String, dynamic> json) {
    print(json);
    // Pointer _pointer = Pointer.fromJson(['points'][0]);
    return Approach(
      uid: _uid,
      dateTime: DateTime.parse(json['dateTime']),
      name: json['name'],
      description: json['description'],
      notes: json['notes'],
      points: List.castFrom(json['points']).map((e) => Pointer.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    List<String> pointsJson = [];
    points.forEach((Pointer e) {
      pointsJson.add(e.toJson().toString());
    });

    return {
      'dateTime': dateTime.toIso8601String(),
      'name': name,
      'description': description,
      'notes': notes,
      'points': pointsJson,
    };
  }
}
