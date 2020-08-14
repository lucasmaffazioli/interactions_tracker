import 'package:cold_app/data/models/interaction/goals_model.dart';
import 'package:cold_app/data/services/floor/floor_gateway.dart';

GoalsModelFloorGateway goalsModelFloorGateway = GoalsModelFloorGateway();

class SaveGoals {
  void call(int weeklyInteractionGoal) async {
    await goalsModelFloorGateway.saveGoalsModel(GoalsModel(weeklyInteractionGoal));
  }
}

// class GetPoint {}

class GetGoals {
  Future<GoalsModel> call() async {
    return goalsModelFloorGateway.findGoalsModel();
  }
}
