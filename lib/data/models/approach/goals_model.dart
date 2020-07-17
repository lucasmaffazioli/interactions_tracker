import 'dart:convert';

import 'package:floor/floor.dart';

@Entity(tableName: 'goals', indices: [])
class GoalsModel {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final int weeklyGoal;

  GoalsModel(this.id, this.weeklyGoal);

  String toJson() {
    return json.encode({
      'id': id.toString(),
      'weeklyGoal': weeklyGoal.toString(),
    });
  }
}
