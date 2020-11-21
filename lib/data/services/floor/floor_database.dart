import 'package:cold_app/data/models/misc/config_model.dart';
import 'package:cold_app/presentation/common/translations.i18n.dart';
import 'dart:async';

import 'package:cold_app/data/models/interaction/interaction_views.dart';
import 'package:cold_app/data/models/interaction/goals_model.dart';
import 'package:cold_app/data/services/floor/dao.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../../models/interaction/interaction_model.dart';
import '../../models/interaction/interaction_points_model.dart';
import '../../models/interaction/point_model.dart';
import 'dao.dart';
part 'floor_database.g.dart';

@Database(
    version: 1,
    entities: [InteractionModel, InteractionPointsModel, PointModel, GoalsModel, ConfigModel],
    views: [InteractionSummaryView, InteractionPointsView])
abstract class AppDatabase extends FloorDatabase {
  InteractionModelDao get interactionModelDao;
  PointModelDao get pointModelDao;
  InteractionPointsModelDao get interactionPointsModelDao;
  InteractionSummaryDao get interactionSummaryDao;
  InteractionPointsViewDao get interactionPointsViewDao;
  GoalsModelDao get goalsModelDao;
  ConfigModelDao get configModelDao;
  // MiscDao get miscDao;
}

//
// - Some helpers
//
void resetDatabase(database) async {
  // await _resetTable(database, 'interaction_points');
  // await _resetTableWithAutoIncrement(database, 'interaction');
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
    // onCreate: (database, version) async {
    //   print('database has been created');

    // },
    // onOpen: (database) {/* database has been opened */},
    // onUpgrade: (database, startVersion, endVersion) {/* database has been upgraded */},
    );

void initializeDatabase(AppDatabase database) async {
  ConfigModel configModel = await database.configModelDao.findConfigModel();

  if (configModel == null
      // || configModel.lastRunVersion == 0 ||
      // configModel.lastRunVersion == null
      ) {
    database.database.rawQuery(
        "INSERT INTO Point(name, pointType, item1, item2, item3, item4, item5) VALUES('${'Visual contact'.i18n}', 'PointType.skill', '${'Weak'.i18n}', '${'Somewhat weak'.i18n}', '${'Neither'.i18n}',' ${'Somewhat strong'.i18n}', '${'Strong'.i18n}');");
    database.database.rawQuery(
        "INSERT INTO Point(name, pointType, item1, item2, item3, item4, item5) VALUES('${'Physical posture'.i18n}', 'PointType.skill', '${'Weak'.i18n}', '${'Somewhat weak'.i18n}', '${'Neither'.i18n}',' ${'Somewhat strong'.i18n}', '${'Strong'.i18n}');");
    database.database.rawQuery(
        "INSERT INTO Point(name, pointType, item1, item2, item3, item4, item5) VALUES('${'Vocal projection'.i18n}', 'PointType.skill', '${'Weak'.i18n}', '${'Somewhat weak'.i18n}', '${'Neither'.i18n}',' ${'Somewhat strong'.i18n}', '${'Strong'.i18n}');");
    database.database.rawQuery(
        "INSERT INTO Point(name, pointType, item1, item2, item3, item4, item5) VALUES('${'Calibration'.i18n}', 'PointType.skill', '${'Weak'.i18n}', '${'Somewhat weak'.i18n}', '${'Neither'.i18n}', '${'Somewhat strong'.i18n}', '${'Strong'.i18n}');");
    database.database.rawQuery(
        "INSERT INTO Point(name, pointType, item1, item2, item3, item4, item5) VALUES('${'Frame'.i18n}', 'PointType.skill', '${'Weak'.i18n}', '${'Somewhat weak'.i18n}', '${'Neither'.i18n}', '${'Somewhat strong'.i18n}', '${'Strong'.i18n}');");
    database.database.rawQuery(
        "INSERT INTO Point(name, pointType, item1, item2, item3, item4, item5) VALUES('${'Boldness'.i18n}', 'PointType.skill', '${'Weak'.i18n}', '${'Somewhat weak'.i18n}', '${'Neither'.i18n}', '${'Somewhat strong'.i18n}', '${'Strong'.i18n}');");
    database.database.rawQuery(
        "INSERT INTO Point(name, pointType, item1, item2, item3, item4, item5) VALUES('${'My appearence'.i18n}', 'PointType.skill', '${'Weak'.i18n}', '${'Somewhat weak'.i18n}', '${'Neither'.i18n}', '${'Somewhat strong'.i18n}', '${'Strong'.i18n}');");
    database.database.rawQuery(
        "INSERT INTO Point(name, pointType, item1, item2, item3, item4, item5) VALUES('${'Confidence'.i18n}', 'PointType.skill', '${'Weak'.i18n}', '${'Somewhat weak'.i18n}', '${'Neither'.i18n}', '${'Somewhat strong'.i18n}', '${'Strong'.i18n}');");
    database.database.rawQuery(
        "INSERT INTO Point(name, pointType, item1, item2, item3, item4, item5) VALUES('${'Difficulty'.i18n}', 'PointType.difficulty', '${'Weak'.i18n}', '${'Somewhat weak'.i18n}', '${'Neither'.i18n}', '${'Somewhat strong'.i18n}', '${'Strong'.i18n}');");
    database.database.rawQuery(
        "INSERT INTO Point(name, pointType, item1, item2, item3, item4, item5) VALUES('${'Attraction'.i18n}', 'PointType.attraction', '${'Weak'.i18n}', '${'Somewhat weak'.i18n}', '${'Neither'.i18n}', '${'Somewhat strong'.i18n}', '${'Strong'.i18n}');");
    database.database.rawQuery(
        "INSERT INTO Point(name, pointType, item1, item2, item3, item4, item5) VALUES('${'Result'.i18n}', 'PointType.result', '${'Weak'.i18n}', '${'Somewhat weak'.i18n}', '${'Neither'.i18n}', '${'Somewhat strong'.i18n}', '${'Strong'.i18n}');");
    database.database.rawQuery("INSERT INTO goals(id, weeklyInteractionGoal) VALUES('1', 10);");
    print('First DB use configured');
    await database.configModelDao.insertConfigModel(ConfigModel(lastRunVersion: 1));
  }
}
