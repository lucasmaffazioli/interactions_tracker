import 'dart:async';

import 'package:cold_app/data/services/floor/point_model_dao.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../../models/approach/approach_model.dart';
import '../../models/approach/approach_points_model.dart';
import '../../models/approach/point_model.dart';
import 'approach_model_dao.dart';

part 'floor_database.g.dart';

@Database(version: 1, entities: [ApproachModel, ApproachPointsModel, PointModel])
abstract class AppDatabase extends FloorDatabase {
  ApproachModelDao get approachModelDao;
  PointModelDao get pointModelDao;
}
