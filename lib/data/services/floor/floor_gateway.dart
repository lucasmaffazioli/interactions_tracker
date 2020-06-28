import 'package:cold_app/core/enums/PointType.dart';
import 'package:cold_app/data/models/approach/point_model.dart';
import 'package:cold_app/data/services/floor/floor_database.dart';
import 'package:cold_app/locator.dart';

class FloorGateway {
  AppDatabase database;

  List<PointModel> listPointOnCreate = [
    PointModel(id: null, name: 'Contato visual', pointType: PointTypeDataLayer.skill),
    PointModel(id: null, name: 'Postura física', pointType: PointTypeDataLayer.skill),
    PointModel(id: null, name: 'Projeção vocal', pointType: PointTypeDataLayer.skill),
    PointModel(id: null, name: 'Calibragem', pointType: PointTypeDataLayer.skill),
    PointModel(id: null, name: 'Frame', pointType: PointTypeDataLayer.skill),
    PointModel(id: null, name: 'Confiança', pointType: PointTypeDataLayer.skill),
    PointModel(id: null, name: 'Atração', pointType: PointTypeDataLayer.attraction),
    PointModel(id: null, name: 'Resultado', pointType: PointTypeDataLayer.result)
  ];

  _setUp() async {
    database = await locator.get<LocatorDatabase>().getDatabase();
  }

  void insertPoint(PointModel point) async {
    await _setUp();
    final pointDao = database.pointModelDao;
    await pointDao.insertPoint(point);
  }

  void updatePoint(PointModel point) async {
    await _setUp();
    final pointDao = database.pointModelDao;
    await pointDao.updatePoint(point);
  }

  Future<List<PointModel>> getAllPoint() async {
    await _setUp();
    final pointDao = database.pointModelDao;

    return await pointDao.findAllPointModels();
  }

  Future<PointModel> getPointById(int id) async {
    await _setUp();
    final pointDao = database.pointModelDao;
    PointModel point = await pointDao.findPointModelById(id);
    return point;
  }

  // void deletePoint(PointModel point) async {
  //   await _setUp();
  //   final pointDao = database.pointModelDao;
  //   pointDao.deletePoint(point);
  // }

  void deletePointById(int id) async {
    await _setUp();
    final pointDao = database.pointModelDao;
    pointDao.deletePointById(id);
  }

  void onCreateDatabase() async {
    // final pointDao = databaseOnCreate.pointModelDao;
    listPointOnCreate.forEach((element) {
      insertPoint(element);
    });
  }

  //
  // - Approach
  //

}
