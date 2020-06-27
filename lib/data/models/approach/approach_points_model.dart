import 'package:floor/floor.dart';
import 'package:flutter/foundation.dart';

import 'point_model.dart';

@Entity(
  tableName: 'approach_points',
  foreignKeys: [
    ForeignKey(
      childColumns: ['approachId'],
      parentColumns: ['id'],
      entity: ApproachPointsModel,
    ),
    ForeignKey(
      childColumns: ['id'],
      parentColumns: ['id'],
      entity: PointModel,
    )
  ],
)
class ApproachPointsModel {
  @primaryKey
  final int approachId;
  @primaryKey
  final int id;
  final int value;

  ApproachPointsModel({
    @required this.approachId,
    @required this.id,
    @required this.value,
  }) {
    if (id == null) throw ArgumentError('Error!');
    if (value == null) throw ArgumentError('Error!');
    if (value < 0 || value > 10) throw ArgumentError('Error!');
  }
}
