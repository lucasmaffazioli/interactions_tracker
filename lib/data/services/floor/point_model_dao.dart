import 'package:cold_app/data/models/approach/point_model.dart';
import 'package:floor/floor.dart';

@dao
abstract class PointModelDao {
  @Query('SELECT * FROM PointModel')
  Future<List<PointModel>> findAllPointModels();

  @Query('SELECT * FROM PointModel WHERE id = :id')
  Stream<PointModel> findPointModelById(int id);

  @insert
  Future<void> insertPoint(PointModel point);

  @update
  Future<void> updatePoint(PointModel point);

  @delete
  Future<void> deletePoint(PointModel point);
}
