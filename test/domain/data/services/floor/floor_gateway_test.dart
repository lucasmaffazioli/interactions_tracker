import 'package:cold_app/core/enums/PointType.dart';
import 'package:cold_app/data/models/approach/point_model.dart';
import 'package:cold_app/data/services/floor/floor_gateway.dart';
import 'package:cold_app/locator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  PointModel testPointModel =
      PointModel(id: null, name: 'Beleza', pointType: PointTypeDataLayer.attraction);

  // AppDatabase database;
  TestWidgetsFlutterBinding.ensureInitialized();
  FloorGateway floorGateway = FloorGateway();

  setUp(() {
    print('setting up locator');
    setupLocator();
    print('finished setting up locator');
    // database = await LocatorDatabase().getDatabase();
    // pointModelDao = database.pointModelDao;
  });

  tearDown(() async {
    // await database.close();
  });

  // test('find person by id', () async {
  //   final point = PointModel(id: null, name: 'Beleza', pointType: PointTypeDataLayer.attraction);
  //   await pointModelDao.insertPoint(point);

  //   final actual = await pointModelDao.findPointModelById(point.id);

  //   expect(actual, equals(point));
  // });

  test('set, read, delete point', () async {
    await floorGateway.setPoint(testPointModel);
    PointModel point = await floorGateway.getPointById(1);
    expect(testPointModel.name, point.name);
    expect(testPointModel.pointType, point.pointType);
  });
  // test('get all approaches', () {});
}
