import 'package:cold_app/data/models/approach/approach_model.dart';
import 'package:cold_app/data/models/approach/approach_points_model.dart';
import 'package:cold_app/data/models/approach/approach_views.dart';
import 'package:cold_app/data/models/approach/goals_model.dart';
import 'package:cold_app/data/models/approach/point_model.dart';
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
abstract class ApproachModelDao {
  @Query('SELECT * FROM approach')
  Future<List<ApproachModel>> findAllApproachModels();

  @Query('SELECT * FROM approach WHERE id = :id')
  Future<ApproachModel> findApproachModelById(int id);

  @insert
  Future<void> insertApproach(ApproachModel approach);

  @update
  Future<void> updateApproach(ApproachModel approach);

  @delete
  Future<void> deleteApproach(ApproachModel approach);

  // @Query('DELETE FROM approach WHERE id = :id')
  // Future<void> deleteApproachById(int id);
  // @Query('DELETE FROM approach WHERE id = :id')
  // Future<int> deleteApproachById(int id);

  ///
  ///  Aqui eu preciso mostrar a media de cada um dos pontos entre um intervalo de tempo
  ///
  ///
  ///
  // @Query(
  //     // 'SELECT * FROM approach_dashboard_view WHERE dateTime >= :initialDate AND dateTime <= :finalDate')
  //     '''
  //     SELECT ap.pointId, p.name AS pointName, AVG(ap.value) AS pointAvg, p.pointType
  //   FROM approach a
  //   INNER JOIN approach_points ap ON a.id = ap.approachId
  //   INNER JOIN point p ON p.id = ap.pointId
  //      WHERE dateTime >= :initialDate AND dateTime <= :finalDate
  //   GROUP BY ap.pointId, pointName, pointType
  //   ORDER BY p.pointType

  //      ''')
  // Future<List<ApproachesDashboardDataView>> findApproachesDashboardDataByInterval(
  //     String initalDate, String finalDate);
}

// @dao
// abstract class MiscDao {
//   @Query(
//       // 'SELECT * FROM approach_dashboard_view WHERE dateTime >= :initialDate AND dateTime <= :finalDate')
//       '''
//       SELECT ap.pointId, p.name AS pointName, AVG(ap.value) AS pointAvg, p.pointType
//     FROM approach a
//     INNER JOIN approach_points ap ON a.id = ap.approachId
//     INNER JOIN point p ON p.id = ap.pointId
//        WHERE dateTime >= :initialDate AND dateTime <= :finalDate
//     GROUP BY ap.pointId, pointName, pointType
//     ORDER BY p.pointType

//        ''')
//   Future<List<DashboardModel>> findApproachesDashboardDataByInterval(
//       String initalDate, String finalDate);
// }

@dao
abstract class ApproachPointsModelDao {
  @Query('SELECT * FROM approach_points WHERE approachId = :approachId AND pointId = :pointId')
  Future<ApproachPointsModel> findApproachPointByApproachAndPointId(int approachId, int pointId);

  @Query('SELECT * FROM approach_points WHERE approachId = :approachId')
  Future<List<ApproachPointsModel>> findApproachPointsByApproachId(int approachId);

  @insert
  Future<void> insertApproachPoints(ApproachPointsModel approachPoints);

  @update
  Future<void> updateApproachPoints(ApproachPointsModel approachPoints);

  @Query('DELETE FROM approach_points WHERE approachId = :approachId')
  Future<void> deleteApproachPointsByApproachId(int approachId);

  @Query('DELETE FROM approach_points WHERE approachId = :approachId AND pointId = :pointId')
  Future<void> deleteApproachPointsByApproachAndPointId(int approachId, int pointId);
}

@dao
abstract class ApproachSummaryDao {
  @Query('SELECT * FROM approach_summary_view')
  Future<List<ApproachSummaryView>> findApproachesSummary();

  @Query('SELECT * FROM approach_summary_view')
  Stream<List<ApproachSummaryView>> findApproachesSummaryStream();
}

@dao
abstract class ApproachPointsViewDao {
  @Query('SELECT * FROM approach_points_view WHERE approachId = :approachId')
  Future<List<ApproachPointsView>> findApproachesPointsByApproachId(int approachId);
}

@dao
abstract class GoalsModelDao {
  @Query('SELECT * FROM goals')
  Future<GoalsModel> findGoalsModel();

  @update
  Future<void> saveGoalsModel(GoalsModel goalsModel);
}

// @dao
// abstract class ApproachesDashboardDataViewDao {
//   @Query(
//       // 'SELECT * FROM approach_dashboard_view WHERE dateTime >= :initialDate AND dateTime <= :finalDate')
//       '''
//       SELECT ap.pointId, p.name AS pointName, AVG(ap.value) AS pointAvg, p.pointType
//     FROM approach a
//     INNER JOIN approach_points ap ON a.id = ap.approachId
//     INNER JOIN point p ON p.id = ap.pointId
//        WHERE dateTime >= :initialDate AND dateTime <= :finalDate
//     GROUP BY ap.pointId, pointName, pointType
//     ORDER BY p.pointType

//        ''')
//   Future<List<ApproachesDashboardDataView>> findApproachesDashboardDataByInterval(
//       String initalDate, String finalDate);
// }
