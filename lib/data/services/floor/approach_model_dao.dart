import 'dart:async';

import 'package:floor/floor.dart';

import '../../models/approach/approach_model.dart';

@dao
abstract class ApproachModelDao {
  @Query('SELECT * FROM ApproachModel')
  Future<List<ApproachModel>> findAllApproachModels();

  @Query('SELECT * FROM ApproachModel WHERE id = :id')
  Stream<ApproachModel> findApproachModelById(int id);

  @insert
  Future<void> insertApproachModel(ApproachModel approach);
}
