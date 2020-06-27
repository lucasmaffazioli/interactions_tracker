import 'package:flutter/foundation.dart';
import 'package:floor/floor.dart';

@Entity(
  tableName: 'approach',
)
class ApproachModel {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String dateTime;
  final String name;
  final String description;
  final String notes;

  ApproachModel({
    @required this.id,
    @required this.dateTime,
    @required this.name,
    @required this.description,
    @required this.notes,
  }) {
    if (id == null) throw ArgumentError('Error!');
    if (dateTime == null) throw ArgumentError('Error!');
    if (name == null) throw ArgumentError('Error!');
    if (description == null) throw ArgumentError('Error!');
    if (notes == null) throw ArgumentError('Error!');
  }
}
