import 'dart:convert';
import 'package:floor/floor.dart';

@Entity(tableName: 'goals', indices: [])
class GoalsModel {
  @PrimaryKey(autoGenerate: true)
  final int id = 1;
  final int weeklyApproachGoal;

  GoalsModel(this.weeklyApproachGoal);

  String toJson() {
    return json.encode({
      'id': id.toString(),
      'weeklyApproachGoal': weeklyApproachGoal.toString(),
    });
  }
}
