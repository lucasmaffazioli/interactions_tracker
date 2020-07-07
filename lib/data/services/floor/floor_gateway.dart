import 'package:cold_app/data/models/approach/approach_points_model.dart';
import 'package:cold_app/data/models/approach/approach_views.dart';

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

  // FloorGateway() async {
  //   database = await locator.get<LocatorDatabase>().getDatabase();
  // }

  _setUp() async {
    // database = await locator.get<LocatorDatabase>().getDatabase();
    database = await locator.get<LocatorDatabase>().getDatabase();
    pointDao = database.pointModelDao;
    approachDao = database.approachModelDao;
    approachPointsDao = database.approachPointsModelDao;
    approachSummaryDao = database.approachSummaryDao;
    approachPointsViewDao = database.approachPointsViewDao;
  }
}

class PointFloorGateway extends FloorGateway {
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
    await _setUp();
    //
    pointDao.deletePointById(id);
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

  void deleteApproachById(int id) async {
    await _setUp();
    //
    approachDao.deleteApproachById(id);
  }

  // Future<int> findLastInsertedApproach() async {
  //   await _setUp();
  //   //
  //   List<Map<String, dynamic>> a = await database.database.rawQuery('SELECT last_insert_rowid()');

  //   return a[0]["last_insert_rowid()"];
  // }
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
}

class ApproachPointsViewFloorGateway extends FloorGateway {
  Future<List<ApproachPointsView>> findApproachesPointsByApproachId(int approachId) async {
    await _setUp();
    //
    return await approachPointsViewDao.findApproachesPointsByApproachId(approachId);
  }
}
