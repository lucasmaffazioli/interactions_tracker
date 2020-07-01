import 'package:cold_app/data/models/approach/approach_model.dart';
import 'package:floor/floor.dart';
import 'package:flutter/foundation.dart';

import 'point_model.dart';

@Entity(
  tableName: 'approach_points',
  foreignKeys: [
    ForeignKey(
      childColumns: ['approachId'],
      parentColumns: ['id'],
      entity: ApproachModel,
    ),
    ForeignKey(
      childColumns: ['pointId'],
      parentColumns: ['id'],
      entity: PointModel,
    )
  ],
)
class ApproachPointsModel {
  @primaryKey
  final int approachId;
  @primaryKey
  final int pointId;
  final int value;

  ApproachPointsModel({
    @required this.approachId,
    @required this.pointId,
    @required this.value,
  }) {
    if (approachId == null) throw ArgumentError('Error!');
    if (pointId == null) throw ArgumentError('Error!');
    if (value == null) throw ArgumentError('Error!');
    if (value < 0 || value > 10) throw ArgumentError('Error!');
  }
}
