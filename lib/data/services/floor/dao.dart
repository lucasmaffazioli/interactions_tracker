import 'package:cold_app/data/models/interaction/interaction_model.dart';
import 'package:cold_app/data/models/interaction/interaction_points_model.dart';
import 'package:cold_app/data/models/interaction/interaction_views.dart';
import 'package:cold_app/data/models/interaction/goals_model.dart';
import 'package:cold_app/data/models/interaction/point_model.dart';
import 'package:cold_app/data/models/misc/config_model.dart';
import 'package:floor/floor.dart';

@dao
abstract class PointModelDao {
  @Query('SELECT * FROM point ORDER BY pointType, name')
  Future<List<PointModel>> findAllPointModels();

  @Query('SELECT * FROM point WHERE id = :id')
  Future<PointModel> findPointModelById(int id);

  @insert
  Future<void> insertPoint(PointModel point);

  @update
  Future<void> updatePoint(PointModel point);

  @delete
  Future<void> deletePoint(PointModel point);

  @Query('DELETE FROM point WHERE id = :id')
  Future<void> deletePointById(int id);
}

@dao
abstract class InteractionModelDao {
  @Query('SELECT * FROM interaction')
  Future<List<InteractionModel>> findAllInteractionModels();

  @Query('SELECT * FROM interaction WHERE id = :id')
  Future<InteractionModel> findInteractionModelById(int id);

  @insert
  Future<void> insertInteraction(InteractionModel interaction);

  @update
  Future<void> updateInteraction(InteractionModel interaction);

  @delete
  Future<void> deleteInteraction(InteractionModel interaction);

  @Query('SELECT * FROM interaction ORDER BY dateTime DESC LIMIT 30')
  Future<List<InteractionModel>> findLast30Interactions();

  // @Query('DELETE FROM interaction WHERE id = :id')
  // Future<void> deleteInteractionById(int id);
  // @Query('DELETE FROM interaction WHERE id = :id')
  // Future<int> deleteInteractionById(int id);

  ///
  ///  Aqui eu preciso mostrar a media de cada um dos pontos entre um intervalo de tempo
  ///
  ///
  ///
  // @Query(
  //     // 'SELECT * FROM interaction_dashboard_view WHERE dateTime >= :initialDate AND dateTime <= :finalDate')
  //     '''
  //     SELECT ap.pointId, p.name AS pointName, AVG(ap.value) AS pointAvg, p.pointType
  //   FROM interaction a
  //   INNER JOIN interaction_points ap ON a.id = ap.interactionId
  //   INNER JOIN point p ON p.id = ap.pointId
  //      WHERE dateTime >= :initialDate AND dateTime <= :finalDate
  //   GROUP BY ap.pointId, pointName, pointType
  //   ORDER BY p.pointType

  //      ''')
  // Future<List<InteractionsDashboardDataView>> findInteractionsDashboardDataByInterval(
  //     String initalDate, String finalDate);
}

// @dao
// abstract class MiscDao {
//   @Query(
//       // 'SELECT * FROM interaction_dashboard_view WHERE dateTime >= :initialDate AND dateTime <= :finalDate')
//       '''
//       SELECT ap.pointId, p.name AS pointName, AVG(ap.value) AS pointAvg, p.pointType
//     FROM interaction a
//     INNER JOIN interaction_points ap ON a.id = ap.interactionId
//     INNER JOIN point p ON p.id = ap.pointId
//        WHERE dateTime >= :initialDate AND dateTime <= :finalDate
//     GROUP BY ap.pointId, pointName, pointType
//     ORDER BY p.pointType

//        ''')
//   Future<List<DashboardModel>> findInteractionsDashboardDataByInterval(
//       String initalDate, String finalDate);
// }

@dao
abstract class InteractionPointsModelDao {
  @Query(
      'SELECT * FROM interaction_points WHERE interactionId = :interactionId AND pointId = :pointId')
  Future<InteractionPointsModel> findInteractionPointByInteractionAndPointId(
      int interactionId, int pointId);

  @Query('SELECT * FROM interaction_points WHERE interactionId = :interactionId')
  Future<List<InteractionPointsModel>> findInteractionPointsByInteractionId(int interactionId);

  @insert
  Future<void> insertInteractionPoints(InteractionPointsModel interactionPoints);

  @update
  Future<void> updateInteractionPoints(InteractionPointsModel interactionPoints);

  @Query('DELETE FROM interaction_points WHERE interactionId = :interactionId')
  Future<void> deleteInteractionPointsByInteractionId(int interactionId);

  @Query(
      'DELETE FROM interaction_points WHERE interactionId = :interactionId AND pointId = :pointId')
  Future<void> deleteInteractionPointsByInteractionAndPointId(int interactionId, int pointId);
}

@dao
abstract class InteractionSummaryDao {
  @Query('SELECT * FROM interaction_summary_view')
  Future<List<InteractionSummaryView>> findInteractionsSummary();

  @Query('SELECT * FROM interaction_summary_view')
  Stream<List<InteractionSummaryView>> findInteractionsSummaryStream();
}

@dao
abstract class InteractionPointsViewDao {
  @Query('SELECT * FROM interaction_points_view WHERE interactionId = :interactionId')
  Future<List<InteractionPointsView>> findInteractionsPointsByInteractionId(int interactionId);
}

@dao
abstract class GoalsModelDao {
  @Query('SELECT * FROM goals')
  Future<GoalsModel> findGoalsModel();

  @update
  Future<void> saveGoalsModel(GoalsModel goalsModel);
}

@dao
abstract class ConfigModelDao {
  @Query('SELECT * FROM config')
  Future<ConfigModel> findConfigModel();

  @insert
  Future<void> insertConfigModel(ConfigModel configModel);

  @update
  Future<void> saveConfigModel(ConfigModel configModel);
}

// @dao
// abstract class InteractionsDashboardDataViewDao {
//   @Query(
//       // 'SELECT * FROM interaction_dashboard_view WHERE dateTime >= :initialDate AND dateTime <= :finalDate')
//       '''
//       SELECT ap.pointId, p.name AS pointName, AVG(ap.value) AS pointAvg, p.pointType
//     FROM interaction a
//     INNER JOIN interaction_points ap ON a.id = ap.interactionId
//     INNER JOIN point p ON p.id = ap.pointId
//        WHERE dateTime >= :initialDate AND dateTime <= :finalDate
//     GROUP BY ap.pointId, pointName, pointType
//     ORDER BY p.pointType

//        ''')
//   Future<List<InteractionsDashboardDataView>> findInteractionsDashboardDataByInterval(
//       String initalDate, String finalDate);
// }
