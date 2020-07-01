import 'dart:async';

import 'package:cold_app/data/services/floor/dao.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../../models/approach/approach_model.dart';
import '../../models/approach/approach_points_model.dart';
import '../../models/approach/point_model.dart';
import 'dao.dart';
part 'floor_database.g.dart';

@Database(version: 1, entities: [ApproachModel, ApproachPointsModel, PointModel])
abstract class AppDatabase extends FloorDatabase {
  ApproachModelDao get approachModelDao;
  PointModelDao get pointModelDao;
  ApproachPointsModelDao get approachPointsModelDao;
}

void resetDatabase(database) async {
  await _resetTable(database, 'approach_points');
  await _resetTableWithAutoIncrement(database, 'approach');
  await _resetTableWithAutoIncrement(database, 'point');
}

void _resetTable(database, String tableName) async {
  await database.database.rawQuery('delete from $tableName');
}

void _resetTableWithAutoIncrement(database, String tableName) async {
  await database.database.rawQuery('DELETE FROM $tableName');
  await database.database.rawQuery("DELETE FROM sqlite_sequence where name='$tableName'");

  List<dynamic> a = await database.database.rawQuery("SELECT * FROM sqlite_sequence");
  print('Resetting table $tableName');
  a.forEach((element) {
    print(element);
  });
  a = await database.database.rawQuery("SELECT * FROM $tableName");
  print('Resetting table $tableName');
  a.forEach((element) {
    print(element);
  });
}
