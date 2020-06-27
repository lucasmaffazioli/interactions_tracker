import 'package:cold_app/data/models/approach/point_model.dart';
import 'package:cold_app/data/services/floor/floor_database.dart';
import 'package:cold_app/locator.dart';

class FloorGateway {
  AppDatabase database;

  void setPoint(PointModel point) async {
    // database = await LocatorDatabase().getDatabase();
    database = await locator.get<LocatorDatabase>().getDatabase();
    final pointDao = database.pointModelDao;

    // final point = Person(1, 'Frank');
    await pointDao.insertPoint(point);
  }

  Future<PointModel> getPointById(int id) async {
    // database = await LocatorDatabase().getDatabase();
    database = await locator.get<LocatorDatabase>().getDatabase();
    final pointDao = database.pointModelDao;
    PointModel point;

    await for (var model in pointDao.findPointModelById(1)) {
      point = model;
      break;
    }

    return point;
  }
}
