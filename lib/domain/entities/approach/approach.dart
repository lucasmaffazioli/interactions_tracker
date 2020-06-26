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
}
