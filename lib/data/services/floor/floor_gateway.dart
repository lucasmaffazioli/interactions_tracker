import 'package:cold_app/data/models/approach/approach_points_model.dart';

import '../../../core/enums/PointType.dart';
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

  // FloorGateway() async {
  //   database = await locator.get<LocatorDatabase>().getDatabase();
  // }

  _setUp() async {
    // database = await locator.get<LocatorDatabase>().getDatabase();
    database = await locator.get<LocatorDatabase>().getDatabase();
    pointDao = database.pointModelDao;
    approachDao = database.approachModelDao;
    approachPointsDao = database.approachPointsModelDao;
  }
}

class PointFloorGateway extends FloorGateway {
  List<PointModel> listPointOnCreate = [
    PointModel(id: null, name: 'Contato visual', pointType: PointTypeDataLayer.skill),
    PointModel(id: null, name: 'Postura  física', pointType: PointTypeDataLayer.skill),
    PointModel(id: null, name: 'Projeção vocal', pointType: PointTypeDataLayer.skill),
    PointModel(id: null, name: 'Calibragem', pointType: PointTypeDataLayer.skill),
    PointModel(id: null, name: 'Frame', pointType: PointTypeDataLayer.skill),
    PointModel(id: null, name: 'Confiança', pointType: PointTypeDataLayer.skill),
    PointModel(id: null, name: 'Atração', pointType: PointTypeDataLayer.attraction),
    PointModel(id: null, name: 'Resultado', pointType: PointTypeDataLayer.result)
  ];

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

  void onCreateDatabase() async {
    // final pointDao = databaseOnCreate.pointModelDao;
    listPointOnCreate.forEach((element) async {
      await insertPoint(element);
    });
  }
}

class ApproachFloorGateway extends FloorGateway {
  void insertApproach(ApproachModel approach) async {
    await _setUp();
    //
    await approachDao.insertApproach(approach);
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

  Future<int> findLastInsertedApproach() async {
    await _setUp();
    //
    List<Map<String, dynamic>> a = await database.database.rawQuery('SELECT last_insert_rowid()');

    return a[0]["last_insert_rowid()"];
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

  Future<List<ApproachPointsModel>> findApproachPointsByApproachId(int id) async {
    await _setUp();
    //
    return await approachPointsDao.findApproachPointsByApproachId(id);
  }

  void deleteApproachPointsById(int id) async {
    await _setUp();
    //
    approachPointsDao.deleteApproachPointsByApproachId(id);
  }
}
