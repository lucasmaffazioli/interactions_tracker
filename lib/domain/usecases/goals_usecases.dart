import 'package:cold_app/data/models/approach/goals_model.dart';
import 'package:cold_app/data/services/floor/floor_gateway.dart';

GoalsModelFloorGateway goalsModelFloorGateway = GoalsModelFloorGateway();

class SaveGoals {
  void call(int weeklyApproachGoal) async {
    await goalsModelFloorGateway.saveGoalsModel(GoalsModel(weeklyApproachGoal));
  }
}

// class GetPoint {}

class GetGoals {
  Future<GoalsModel> call() async {
    return goalsModelFloorGateway.findGoalsModel();
  }
}
