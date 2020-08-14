import 'package:cold_app/data/models/interaction/interaction_points_model.dart';
import 'package:cold_app/data/models/interaction/interaction_views.dart';
import 'package:cold_app/data/models/interaction/dashboard.dart';
import 'package:cold_app/data/models/interaction/goals_model.dart';
import 'package:cold_app/data/models/misc/config_model.dart';

import '../../../locator.dart';
import '../../models/interaction/interaction_model.dart';
import '../../models/interaction/point_model.dart';
import 'floor_database.dart';
import 'dao.dart';

class FloorGateway {
  AppDatabase database;
  PointModelDao pointDao;
  InteractionModelDao interactionDao;
  InteractionPointsModelDao interactionPointsDao;
  InteractionSummaryDao interactionSummaryDao;
  InteractionPointsViewDao interactionPointsViewDao;
  GoalsModelDao goalsModelDao;
  ConfigModelDao configModelDao;
  // MiscDao miscDao;

  _setUp() async {
    // database = await locator.get<LocatorDatabase>().getDatabase();
    database = await locator.get<AppDatabase>();
    pointDao = database.pointModelDao;
    interactionDao = database.interactionModelDao;
    interactionPointsDao = database.interactionPointsModelDao;
    interactionSummaryDao = database.interactionSummaryDao;
    interactionPointsViewDao = database.interactionPointsViewDao;
    goalsModelDao = database.goalsModelDao;
    configModelDao = database.configModelDao;
    // miscDao = database.miscDao;
  }
}

class PointFloorGateway extends FloorGateway {
  void savePoint(PointModel point) async {
    await _setUp();
    //
    print(point.toJson());
    if (point.id == null || point.id == 0) {
      await pointDao.insertPoint(point);
    } else {
      await pointDao.updatePoint(point);
    }
  }

  void insertPoint(PointModel point) async {
    await _setUp();
    //
    await pointDao.insertPoint(point);
  }

  void updatePoint(PointModel point) async {
    await _setUp();
    //
    await pointDao.updatePoint(point);
  }

  Future<List<PointModel>> getAllPoint() async {
    await _setUp();
    //
    return await pointDao.findAllPointModels();
  }

  Future<PointModel> getPointById(int id) async {
    await _setUp();
    //
    PointModel point = await pointDao.findPointModelById(id);
    return point;
  }

  void deletePointById(int id) async {
    if (id != null && id != 0) {
      await _setUp();
      //
      pointDao.deletePointById(id);
    }
  }

  // void onCreateDatabase() async {
  //   // final pointDao = databaseOnCreate.pointModelDao;
  //   listPointOnCreate.forEach((element) async {
  //     await insertPoint(element);
  //   });
  // }
}

class InteractionFloorGateway extends FloorGateway {
  Future<int> insertInteraction(InteractionModel interaction) async {
    await _setUp();
    //
    await interactionDao.insertInteraction(interaction);
    //
    List<Map<String, dynamic>> a = await database.database.rawQuery('SELECT last_insert_rowid()');

    return a[0]["last_insert_rowid()"];
  }

  void updateInteraction(InteractionModel interaction) async {
    await _setUp();
    //
    await interactionDao.updateInteraction(interaction);
  }

  Future<List<InteractionModel>> getAllInteractions() async {
    await _setUp();
    //
    return await interactionDao.findAllInteractionModels();
  }

  Future<List<InteractionModel>> getLast30Interactions() async {
    await _setUp();
    //
    return await interactionDao.findLast30Interactions();
  }

  Future<InteractionModel> getInteractionById(int id) async {
    await _setUp();
    //
    InteractionModel interaction = await interactionDao.findInteractionModelById(id);
    return interaction;
  }

  Future<void> deleteInteraction(InteractionModel interaction) async {
    await _setUp();
    //
    return interactionDao.deleteInteraction(interaction);
  }

  // Future<int> findLastInsertedInteraction() async {
  //   await _setUp();
  //   //
  //   List<Map<String, dynamic>> a = await database.database.rawQuery('SELECT last_insert_rowid()');

  //   return a[0]["last_insert_rowid()"];
  // }
  Future<dynamic> getInteractionsDashboardData(initialDate, finalDate) async {
    await _setUp();
    // return interactionDao.getInteractionsDashboardData(initialDate, finalDate);
  }

  Future<int> findInteractionsCountByDateInterval(DateTime initialDate, DateTime finalDate) async {
    await _setUp();
    //
    int returnValue = 0;

    await database.database.rawQuery('''
       SELECT count(*) AS interactions
        FROM interaction 
          WHERE dateTime >= :initialDate AND dateTime <= :finalDate
      ''', [initialDate.toIso8601String(), finalDate.toIso8601String()]).then(
      (value) => value.forEach(
        (element) {
          returnValue = DashboardInteractionsCountModel.fromMap(element).interactions;
        },
      ),
    );

    return returnValue;
  }

  Future<List<DashboardComplexModel>> findDashboardDataByDateInterval(
      DateTime initialDate, DateTime finalDate) async {
    await _setUp();
    //
    List<DashboardComplexModel> returnList = [];

    await database.database.rawQuery('''
        SELECT ap.pointId, p.name AS pointName, AVG(ap.value) AS pointAvg, p.pointType
          FROM interaction a
          INNER JOIN interaction_points ap ON a.id = ap.interactionId
          INNER JOIN point p ON p.id = ap.pointId
            WHERE dateTime >= :initialDate AND dateTime <= :finalDate
          GROUP BY ap.pointId, pointName, pointType
          ORDER BY p.pointType
            
        ''', [initialDate.toIso8601String(), finalDate.toIso8601String()]).then(
      (value) => value.forEach(
        (element) {
          returnList.add(DashboardComplexModel.fromMap(element));
        },
      ),
    );
    // return await miscDao.findInteractionsDashboardDataByInterval(
    //     initialDate.toIso8601String(), finalDate.toIso8601String());
    return returnList;
  }
}

class InteractionPointsFloorGateway extends FloorGateway {
  void insertInteractionPoints(InteractionPointsModel interaction) async {
    await _setUp();
    //
    await interactionPointsDao.insertInteractionPoints(interaction);
  }

  void updateInteractionPoints(InteractionPointsModel interaction) async {
    await _setUp();
    //
    await interactionPointsDao.updateInteractionPoints(interaction);
  }

  Future<List<InteractionPointsModel>> findInteractionPointsByInteractionId(
      int interactionId) async {
    await _setUp();
    //
    return await interactionPointsDao.findInteractionPointsByInteractionId(interactionId);
  }

  void deleteInteractionPointsByInteractionId(int interactionId) async {
    await _setUp();
    //
    interactionPointsDao.deleteInteractionPointsByInteractionId(interactionId);
  }
}

class InteractionSummaryViewFloorGateway extends FloorGateway {
  Future<List<InteractionSummaryView>> findInteractionsSummary() async {
    await _setUp();
    //
    return await interactionSummaryDao.findInteractionsSummary();
  }

  Stream<List<InteractionSummaryView>> findInteractionsSummaryStream() {
    // _setUp();
    //
    return locator.get<AppDatabase>().interactionSummaryDao.findInteractionsSummaryStream();
  }
}

class InteractionPointsViewFloorGateway extends FloorGateway {
  Future<List<InteractionPointsView>> findInteractionsPointsByInteractionId(
      int interactionId) async {
    await _setUp();
    //
    return await interactionPointsViewDao.findInteractionsPointsByInteractionId(interactionId);
  }
}

class GoalsModelFloorGateway extends FloorGateway {
  Future<GoalsModel> findGoalsModel() async {
    await _setUp();
    //
    return await goalsModelDao.findGoalsModel();
  }

  Future<void> saveGoalsModel(GoalsModel goalsModel) async {
    await _setUp();
    //
    return await goalsModelDao.saveGoalsModel(goalsModel);
  }
}

class ConfigModelFloorGateway extends FloorGateway {
  Future<ConfigModel> findConfigModel() async {
    await _setUp();
    //
    return await configModelDao.findConfigModel();
  }

  Future<void> saveConfigModel(ConfigModel configModel) async {
    await _setUp();
    //
    return await configModelDao.saveConfigModel(configModel);
  }
}

// class InteractionsDashboardDataViewGateway extends FloorGateway {
//   Future<List<InteractionsDashboardDataView>> findDashboardDataByDateInterval(
//       DateTime initialDate, DateTime finalDate) async {
//     await _setUp();
//     //
//     return await dashboardDataViewDao.findInteractionsDashboardDataByInterval(
//         initialDate.toIso8601String(), finalDate.toIso8601String());
//   }
// }
