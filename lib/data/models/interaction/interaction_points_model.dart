import 'dart:convert';

import 'package:cold_app/data/models/interaction/interaction_model.dart';
import 'package:cold_app/presentation/common/constants.dart';
import 'package:floor/floor.dart';
import 'package:flutter/foundation.dart';

import 'point_model.dart';

@Entity(
  tableName: 'interaction_points',
  primaryKeys: ['interactionId', 'pointId'],
  foreignKeys: [
    ForeignKey(
      childColumns: ['interactionId'],
      parentColumns: ['id'],
      entity: InteractionModel,
      onDelete: ForeignKeyAction.cascade,
    ),
    ForeignKey(
      childColumns: ['pointId'],
      parentColumns: ['id'],
      entity: PointModel,
      onDelete: ForeignKeyAction.cascade,
    )
  ],
)
class InteractionPointsModel {
  final int interactionId;
  final int pointId;
  final int value;

  InteractionPointsModel({
    @required this.interactionId,
    @required this.pointId,
    @required this.value,
  }) {
    if (interactionId == null) throw ArgumentError('Error!');
    if (pointId == null) throw ArgumentError('Error!');
    if (value == null) throw ArgumentError('Error!');
    if (value < Constants.minPoints || value > Constants.maxPoints) throw ArgumentError('Error!');
  }

  String toJson() {
    return json.encode({
      'interactionId': interactionId.toString(),
      'pointId': pointId.toString(),
      'value': value.toString(),
    });
  }
}
