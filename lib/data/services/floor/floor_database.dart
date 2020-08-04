import 'package:cold_app/presentation/common/translations.i18n.dart';
import 'dart:async';

import 'package:cold_app/data/models/approach/approach_views.dart';
import 'package:cold_app/data/models/approach/goals_model.dart';
import 'package:cold_app/data/services/floor/dao.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../../models/approach/approach_model.dart';
import '../../models/approach/approach_points_model.dart';
import '../../models/approach/point_model.dart';
import 'dao.dart';
part 'floor_database.g.dart';

@Database(
    version: 1,
    entities: [ApproachModel, ApproachPointsModel, PointModel, GoalsModel],
    views: [ApproachSummaryView, ApproachPointsView])
abstract class AppDatabase extends FloorDatabase {
  ApproachModelDao get approachModelDao;
  PointModelDao get pointModelDao;
  ApproachPointsModelDao get approachPointsModelDao;
  ApproachSummaryDao get approachSummaryDao;
  ApproachPointsViewDao get approachPointsViewDao;
  GoalsModelDao get goalsModelDao;
  // MiscDao get miscDao;
}

//
// - Some helpers
//
void resetDatabase(database) async {
  // await _resetTable(database, 'approach_points');
  // await _resetTableWithAutoIncrement(database, 'approach');
  // await _resetTableWithAutoIncrement(database, 'point');
}

// void _resetTable(database, String tableName) async {
//   await database.database.rawQuery('delete from $tableName');
// }

// void _resetTableWithAutoIncrement(database, String tableName) async {
//   await database.database.rawQuery('DELETE FROM $tableName');
//   await database.database.rawQuery("DELETE FROM sqlite_sequence where name='$tableName'");

//   List<dynamic> a = await database.database.rawQuery("SELECT * FROM sqlite_sequence");
//   print('Resetting table $tableName');
//   a.forEach((element) {
//     print(element);
//   });
//   a = await database.database.rawQuery("SELECT * FROM $tableName");
//   print('Resetting table $tableName');
//   a.forEach((element) {
//     print(element);
//   });
// }

final dbCallback = Callback(
  onCreate: (database, version) async {
    print('database has been created');

    database.rawQuery(
        "INSERT INTO Point(name, pointType, item1, item2, item3, item4, item5) VALUES('${'Visual contact'.i18n} visual', 'skill', '${'Weak'.i18n}', '${'Somewhat weak'.i18n}', '${'Neither'.i18n}',' ${'Somewhat strong'.i18n}', '${'Strong'.i18n}');");
    database.rawQuery(
        "INSERT INTO Point(name, pointType, item1, item2, item3, item4, item5) VALUES('${'Physical posture'.i18n} física', 'skill', '${'Weak'.i18n}', '${'Somewhat weak'.i18n}', '${'Neither'.i18n}',' ${'Somewhat strong'.i18n}', '${'Strong'.i18n}');");
    database.rawQuery(
        "INSERT INTO Point(name, pointType, item1, item2, item3, item4, item5) VALUES('${'Vocal projection'.i18n} vocal', 'skill', '${'Weak'.i18n}', '${'Somewhat weak'.i18n}', '${'Neither'.i18n}',' ${'Somewhat strong'.i18n}', '${'Strong'.i18n}');");
    database.rawQuery(
        "INSERT INTO Point(name, pointType, item1, item2, item3, item4, item5) VALUES('${'Calibration'.i18n}', 'skill', '${'Weak'.i18n}', '${'Somewhat weak'.i18n}', '${'Neither'.i18n}', '${'Somewhat strong'.i18n}', '${'Strong'.i18n}');");
    database.rawQuery(
        "INSERT INTO Point(name, pointType, item1, item2, item3, item4, item5) VALUES('${'Frame'.i18n}', 'skill', '${'Weak'.i18n}', '${'Somewhat weak'.i18n}', '${'Neither'.i18n}', '${'Somewhat strong'.i18n}', '${'Strong'.i18n}');");
    database.rawQuery(
        "INSERT INTO Point(name, pointType, item1, item2, item3, item4, item5) VALUES('${'Boldness'.i18n}', 'skill', '${'Weak'.i18n}', '${'Somewhat weak'.i18n}', '${'Neither'.i18n}', '${'Somewhat strong'.i18n}', '${'Strong'.i18n}');");
    database.rawQuery(
        "INSERT INTO Point(name, pointType, item1, item2, item3, item4, item5) VALUES('${'My own styling'.i18n}', 'skill', '${'Weak'.i18n}', '${'Somewhat weak'.i18n}', '${'Neither'.i18n}', '${'Somewhat strong'.i18n}', '${'Strong'.i18n}');");
    database.rawQuery(
        "INSERT INTO Point(name, pointType, item1, item2, item3, item4, item5) VALUES('${'Confidence'.i18n}', 'skill', '${'Weak'.i18n}', '${'Somewhat weak'.i18n}', '${'Neither'.i18n}', '${'Somewhat strong'.i18n}', '${'Strong'.i18n}');");
    database.rawQuery(
        "INSERT INTO Point(name, pointType, item1, item2, item3, item4, item5) VALUES('${'Difficulty'.i18n}', 'difficulty', '${'Weak'.i18n}', '${'Somewhat weak'.i18n}', '${'Neither'.i18n}', '${'Somewhat strong'.i18n}', '${'Strong'.i18n}');");
    database.rawQuery(
        "INSERT INTO Point(name, pointType, item1, item2, item3, item4, item5) VALUES('${'Attraction'.i18n}', 'attraction', '${'Weak'.i18n}', '${'Somewhat weak'.i18n}', '${'Neither'.i18n}', '${'Somewhat strong'.i18n}', '${'Strong'.i18n}');");
    database.rawQuery(
        "INSERT INTO Point(name, pointType, item1, item2, item3, item4, item5) VALUES('${'Result'.i18n}', 'result', '${'Weak'.i18n}', '${'Somewhat weak'.i18n}', '${'Neither'.i18n}', '${'Somewhat strong'.i18n}', '${'Strong'.i18n}');");
    database.rawQuery("INSERT INTO goals(id, weeklyApproachGoal) VALUES('1', 10);");

    print('First DB use configured');
  },
  onOpen: (database) {/* database has been opened */},
  onUpgrade: (database, startVersion, endVersion) {/* database has been upgraded */},
);
