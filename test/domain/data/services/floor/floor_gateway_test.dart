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

  setUpAll(() {
    locator.reset();
    setupLocator();
    // floorGateway.onCreateDatabase();
  });

  tearDown(() async {
    // await database.close();
  });

  test('set, read, delete point', () async {
    await floorGateway.insertPoint(testPointModel);
    PointModel point = await floorGateway.getPointById(1);
    expect(point.id, 1);
    expect(point.name, testPointModel.name);
    expect(point.pointType, testPointModel.pointType);
    //
    await floorGateway.deletePointById(1);
    point = await floorGateway.getPointById(1);
    expect(point, null);
  });

  test('list points', () async {
    floorGateway.onCreateDatabase();
    List<PointModel> list = await floorGateway.getAllPoint();

    list.forEach((element) {
      print('Id ${element.id}, name ${element.name}, Type ${element.pointType}');
    });

    expect(list[0].name, floorGateway.listPointOnCreate[0].name);
    expect(list[1].id, 3);
    expect(list[2].pointType, floorGateway.listPointOnCreate[0].pointType);
  });

  test('Change point', () async {
    List<PointModel> list = await floorGateway.getAllPoint();

    list.forEach((element) {
      print('Id ${element.id}, name ${element.name}, Type ${element.pointType}');
    });

    // await floorGateway.insertPoint(testPointModel);
    PointModel oldPoint = await floorGateway.getPointById(2);
    print(oldPoint.id);
    print(oldPoint.name);
    PointModel point =
        PointModel(id: oldPoint.id, name: 'Updated name', pointType: oldPoint.pointType);
    await floorGateway.updatePoint(point);
    //
    PointModel updatedPoint = await floorGateway.getPointById(2);
    expect(updatedPoint.id, oldPoint.id);
    expect(updatedPoint.name, 'Updated name');
    expect(updatedPoint.pointType, oldPoint.pointType);
  });
}
