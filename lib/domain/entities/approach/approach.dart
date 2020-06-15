import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/foundation.dart';
import 'pointer.dart';

// part 'approach.g.dart';

// @JsonSerializable(nullable: false)
class Approach {
  final String uid;
  final DateTime dateTime;
  final String name;
  final String description;
  final String notes;

  // @JsonKey(fromJson: _dataFromJson, toJson: _dataToJson)
  final List<Pointer> points;

  Approach({
    @required this.uid,
    @required this.dateTime,
    @required this.name,
    @required this.description,
    @required this.notes,
    @required this.points,
    // @required this.attraction,
    // @required this.result,
  }) {
    if (uid == null) throw ArgumentError('Error!');
    if (dateTime == null) throw ArgumentError('Error!');
    if (name == null) throw ArgumentError('Error!');
    if (description == null) throw ArgumentError('Error!');
    if (notes == null) throw ArgumentError('Error!');
    // if (skills == null) throw ArgumentError('Error!');
    // if (attraction == null) throw ArgumentError('Error!');
    // if (result == null) throw ArgumentError('Error!');
  }

  // factory Approach.fromJson(Map<String, dynamic> json) => _$ApproachFromJson(json);
  // Map<String, dynamic> toJson() => _$ApproachToJson(this);

  factory Approach.fromJson(String _uid, Map<String, dynamic> json) {
    return Approach(
      uid: _uid,
      dateTime: DateTime.parse(json['dateTime']),
      name: json['name'],
      description: json['description'],
      notes: json['notes'],
      points: List.castFrom(['points']),

      // text: json['text'],
      // number: (json['number'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    print('+-------------');
    print(points);
    List<String> pointsJson = [];

    points.forEach((Pointer e) {
      print(e.name);
      pointsJson.add(e.toJson().toString());
    });
    print('++++++++++++++');
    points.map((Pointer e) {
      print(e.name);
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

// T _dataFromJson<T, S, U>(Map<String, dynamic> input, [S other1, U other2]) => input['value'] as T;

// Map<String, dynamic> _dataToJson<T, S, U>(T input, [S other1, U other2]) => {'value': input};
