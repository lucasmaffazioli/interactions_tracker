import 'dart:convert';
import 'package:floor/floor.dart';

@Entity(tableName: 'goals', indices: [])
class GoalsModel {
  @PrimaryKey(autoGenerate: true)
  final int id = 1;
  final int weeklyInteractionGoal;

  GoalsModel(this.weeklyInteractionGoal) {
    if (weeklyInteractionGoal == null || weeklyInteractionGoal > 100 || weeklyInteractionGoal < 1)
      throw ArgumentError('Error!');
  }

  String toJson() {
    return json.encode({
      'id': id.toString(),
      'weeklyInteractionGoal': weeklyInteractionGoal.toString(),
    });
  }
}
