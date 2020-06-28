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
