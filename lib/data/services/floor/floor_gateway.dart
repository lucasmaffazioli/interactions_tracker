import 'package:cold_app/data/models/approach/approach_points_model.dart';
import 'package:cold_app/data/models/approach/approach_views.dart';
import 'package:cold_app/data/models/approach/dashboard.dart';
import 'package:cold_app/data/models/approach/goals_model.dart';

import '../../../locator.dart';
import '../../models/approach/approach_model.dart';
import '../../models/approach/point_model.dart';
import 'floor_database.dart';
import 'dao.dart';

class FloorGateway {
  AppDatabase database;
  PointModelDao pointDao;
  ApproachModelDao approachDao;
  ApproachPointsModelDao approachPointsDao;
  ApproachSummaryDao approachSummaryDao;
  ApproachPointsViewDao approachPointsViewDao;
  GoalsModelDao goalsModelDao;
  // MiscDao miscDao;

  _setUp() async {
    // database = await locator.get<LocatorDatabase>().getDatabase();
    database = await locator.get<AppDatabase>();
    pointDao = database.pointModelDao;
    approachDao = database.approachModelDao;
    approachPointsDao = database.approachPointsModelDao;
    approachSummaryDao = database.approachSummaryDao;
    approachPointsViewDao = database.approachPointsViewDao;
    goalsModelDao = database.goalsModelDao;
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

class ApproachFloorGateway extends FloorGateway {
  Future<int> insertApproach(ApproachModel approach) async {
    await _setUp();
    //
    await approachDao.insertApproach(approach);
    //
    List<Map<String, dynamic>> a = await database.database.rawQuery('SELECT last_insert_rowid()');

    return a[0]["last_insert_rowid()"];
  }

  void updateApproach(ApproachModel approach) async {
    await _setUp();
    //
    await approachDao.updateApproach(approach);
  }

  Future<List<ApproachModel>> getAllApproach() async {
    await _setUp();
    //

    return await approachDao.findAllApproachModels();
  }

  Future<ApproachModel> getApproachById(int id) async {
    await _setUp();
    //
    ApproachModel approach = await approachDao.findApproachModelById(id);
    return approach;
  }

  Future<void> deleteApproach(ApproachModel approach) async {
    await _setUp();
    //
    return approachDao.deleteApproach(approach);
  }

  // Future<int> findLastInsertedApproach() async {
  //   await _setUp();
  //   //
  //   List<Map<String, dynamic>> a = await database.database.rawQuery('SELECT last_insert_rowid()');

  //   return a[0]["last_insert_rowid()"];
  // }
  Future<dynamic> getApproachesDashboardData(initialDate, finalDate) async {
    await _setUp();
    // return approachDao.getApproachesDashboardData(initialDate, finalDate);
  }

  Future<int> findApproachesCountByDateInterval(DateTime initialDate, DateTime finalDate) async {
    await _setUp();
    //
    int returnValue = 0;

    await database.database.rawQuery('''
       SELECT count(*) AS approaches
        FROM approach 
          WHERE dateTime >= :initialDate AND dateTime <= :finalDate
      ''', [initialDate.toIso8601String(), finalDate.toIso8601String()]).then(
      (value) => value.forEach(
        (element) {
          returnValue = DashboardApproachesCountModel.fromMap(element).approaches;
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
          FROM approach a
          INNER JOIN approach_points ap ON a.id = ap.approachId
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
    // return await miscDao.findApproachesDashboardDataByInterval(
    //     initialDate.toIso8601String(), finalDate.toIso8601String());
    return returnList;
  }
}

class ApproachPointsFloorGateway extends FloorGateway {
  void insertApproachPoints(ApproachPointsModel approach) async {
    await _setUp();
    //
    await approachPointsDao.insertApproachPoints(approach);
  }

  void updateApproachPoints(ApproachPointsModel approach) async {
    await _setUp();
    //
    await approachPointsDao.updateApproachPoints(approach);
  }

  Future<List<ApproachPointsModel>> findApproachPointsByApproachId(int approachId) async {
    await _setUp();
    //
    return await approachPointsDao.findApproachPointsByApproachId(approachId);
  }

  void deleteApproachPointsByApproachId(int approachId) async {
    await _setUp();
    //
    approachPointsDao.deleteApproachPointsByApproachId(approachId);
  }
}

class ApproachSummaryViewFloorGateway extends FloorGateway {
  Future<List<ApproachSummaryView>> findApproachesSummary() async {
    await _setUp();
    //
    return await approachSummaryDao.findApproachesSummary();
  }

  Stream<List<ApproachSummaryView>> findApproachesSummaryStream() {
    // _setUp();
    //
    return locator.get<AppDatabase>().approachSummaryDao.findApproachesSummaryStream();
  }
}

class ApproachPointsViewFloorGateway extends FloorGateway {
  Future<List<ApproachPointsView>> findApproachesPointsByApproachId(int approachId) async {
    await _setUp();
    //
    return await approachPointsViewDao.findApproachesPointsByApproachId(approachId);
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

// class ApproachesDashboardDataViewGateway extends FloorGateway {
//   Future<List<ApproachesDashboardDataView>> findDashboardDataByDateInterval(
//       DateTime initialDate, DateTime finalDate) async {
//     await _setUp();
//     //
//     return await dashboardDataViewDao.findApproachesDashboardDataByInterval(
//         initialDate.toIso8601String(), finalDate.toIso8601String());
//   }
// }
