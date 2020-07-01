import 'package:cold_app/data/models/approach/approach_model.dart';
import 'package:cold_app/data/models/approach/approach_points_model.dart';
import 'package:cold_app/data/models/approach/point_model.dart';
import 'package:floor/floor.dart';

@dao
abstract class PointModelDao {
  @Query('SELECT * FROM point')
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

  @Query('DELETE FROM approach WHERE id = :id')
  Future<void> deleteApproachById(int id);
}

@dao
abstract class ApproachPointsModelDao {
  // @Query('SELECT * FROM approach')
  // Future<List<ApproachPointsModel>> findAllApproachPointsModel();

  @Query('SELECT * FROM approach WHERE id = :id')
  Future<ApproachPointsModel> findApproachPointsModelByApproachId(int id);

  @insert
  Future<void> insertApproachPoints(ApproachPointsModel approachPoints);

  @update
  Future<void> updateApproachPoints(ApproachPointsModel approachPoints);

  @delete
  Future<void> deleteApproachPoints(ApproachPointsModel approachPoints);

  @Query('DELETE FROM approach WHERE id = :id')
  Future<void> deleteApproachPointsByApproachId(int id);
}
