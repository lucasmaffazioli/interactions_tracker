import 'package:cold_app/domain/entities/approach/point_entity.dart';
import 'package:flutter/foundation.dart';

class ApproachEntity {
  final int id;
  final DateTime dateTime;
  final String name;
  final String description;
  final String notes;
  final List<PointEntity> points;

  ApproachEntity({
    @required this.id,
    @required this.dateTime,
    @required this.name,
    @required this.description,
    @required this.notes,
    @required this.points,
  }) {
    if (id == null) throw ArgumentError('Error!');
    if (dateTime == null) throw ArgumentError('Error!');
    if (name == null) throw ArgumentError('Error!');
    if (description == null) throw ArgumentError('Error!');
    if (notes == null) throw ArgumentError('Error!');
  }
}