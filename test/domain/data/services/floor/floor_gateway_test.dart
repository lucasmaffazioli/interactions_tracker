import 'package:cold_app/core/enums/PointType.dart';
import 'package:cold_app/data/models/approach/approach_model.dart';
import 'package:cold_app/data/models/approach/point_model.dart';
import 'package:cold_app/data/services/floor/floor_gateway.dart';
import 'package:cold_app/locator.dart';
import 'package:flutter_test/flutter_test.dart';

// TODO - Fix these tests. I couldn't reset the in-memory floor database, so I did this
// tracker: https://github.com/vitusortner/floor/issues/367

void main() {
  group('PointModel', () {
    PointModel testPointModel =
        PointModel(id: null, name: 'Beleza', pointType: PointTypeDataLayer.attraction);

    // AppDatabase database;
    TestWidgetsFlutterBinding.ensureInitialized();
    PointFloorGateway pointFloorGateway = PointFloorGateway();

    setUp(() {
      setupLocator();
    });

    tearDown(() {
      locator.reset();
    });

    test('set, read, delete point', () async {
      await pointFloorGateway.insertPoint(testPointModel);

      List<PointModel> list = await pointFloorGateway.getAllPoint();

      list.forEach((element) {
        print('Id ${element.id}, name ${element.name}');
      });

      PointModel point = await pointFloorGateway.getPointById(1);
      expect(point.id, 1);
      expect(point.name, testPointModel.name);
      expect(point.pointType, testPointModel.pointType);
      //
      await pointFloorGateway.deletePointById(1);
      point = await pointFloorGateway.getPointById(1);
      expect(point, null);
    });

    test('list points', () async {
      pointFloorGateway.onCreateDatabase();
      List<PointModel> list = await pointFloorGateway.getAllPoint();

      list.forEach((element) {
        print('Id ${element.id}, name ${element.name}, Type ${element.pointType}');
      });

      expect(list[0].name, pointFloorGateway.listPointOnCreate[0].name);
      expect(list[1].id, 2);
      expect(list[7].pointType, pointFloorGateway.listPointOnCreate[7].pointType);
    });

    test('Change point', () async {
      await pointFloorGateway.insertPoint(testPointModel);
      PointModel oldPoint = await pointFloorGateway.getPointById(1);
      PointModel modifiedPoint =
          PointModel(id: oldPoint.id, name: 'Updated name', pointType: oldPoint.pointType);
      await pointFloorGateway.updatePoint(modifiedPoint);
      //
      PointModel updatedPoint = await pointFloorGateway.getPointById(1);
      //
      expect(updatedPoint.id, oldPoint.id);
      expect(updatedPoint.name, 'Updated name');
      expect(updatedPoint.pointType, oldPoint.pointType);
    });
  });

  ///
  /// - Approaches
  ///
  group('ApproachModel', () {
    ApproachModel testApproachModel = ApproachModel(
        dateTime: DateTime(2020, 01, 15).toIso8601String(),
        name: 'Harry Potter',
        description: 'Nice scar, homie',
        notes: 'Did sum wizard type of shit mane');

    ApproachFloorGateway floorGateway = ApproachFloorGateway();

    setUp(() async {
      print('Setup All do ApproachModel');
      // await resetLocator();
      // locator.reset();
      locator.reset();
      setupLocator();
      // resetLocator();
    });

    // tearDown(() async {
    //   locator.reset();
    //   // await database.close();
    // });

    test('set, read, delete approach', () async {
      await floorGateway.insertApproach(testApproachModel);

      // List<ApproachModel> list = await floorGateway.approachDao.findAllApproachModels();

      // list.forEach((element) {
      //   print('Id ${element.id}, name ${element.name}');
      // });

      ApproachModel approach = await floorGateway.getApproachById(1);
      expect(approach.id, 1);
      expect(approach.dateTime, testApproachModel.dateTime);
      expect(approach.name, testApproachModel.name);
      expect(approach.description, testApproachModel.description);
      expect(approach.notes, testApproachModel.notes);
      //
      await floorGateway.deleteApproachById(1);
      approach = await floorGateway.getApproachById(1);
      expect(approach, null);
    });

    test('list approaches', () async {
      await floorGateway.insertApproach(
        ApproachModel(
            dateTime: DateTime(2020, 01, 15).toIso8601String(),
            name: 'Harry Potter',
            description: 'Nice scar, homie',
            notes: 'Did sum wizard type of shit mane'),
      );
      await floorGateway.insertApproach(
        ApproachModel(
            dateTime: DateTime(2020, 02, 15).toIso8601String(),
            name: 'Joana Dark',
            description: 'Lady o nite',
            notes: 'Shining'),
      );
      //
      List<ApproachModel> list = await floorGateway.getAllApproach();
      list.forEach((element) {
        print(element.toJson());
      });

      expect(list[0].id, 1);
      expect(list[0].dateTime, DateTime(2020, 01, 15).toIso8601String());
      expect(list[1].name, 'Joana Dark');
      expect(list[1].description, 'Lady o nite');
      expect(list[1].notes, 'Shining');
    });

    test('Change approach', () async {
      await floorGateway.insertApproach(testApproachModel);
      ApproachModel oldApproach = await floorGateway.getApproachById(1);
      ApproachModel modifiedApproach = ApproachModel(
          id: 1,
          dateTime: DateTime(2020, 02, 15).toIso8601String(),
          name: 'Updated name',
          description: 'Updated description',
          notes: 'Updated note');

      await floorGateway.updateApproach(modifiedApproach);
      //
      ApproachModel updatedApproach = await floorGateway.getApproachById(1);
      //
      expect(updatedApproach.id, oldApproach.id);
      expect(updatedApproach.name, 'Updated name');
      expect(updatedApproach.description, 'Updated description');
      expect(updatedApproach.notes, 'Updated note');
    });
  });

  // group('ApproachPointsModel', () {
  //   ApproachModel testApproachModel = ApproachModel(
  //       dateTime: DateTime(2020, 01, 15).toIso8601String(),
  //       name: 'Harry Potter',
  //       description: 'Nice scar, homie',
  //       notes: 'Did sum wizard type of shit mane');

  //   ApproachFloorGateway floorGateway = ApproachFloorGateway();

  //   setUp(() async {
  //     print('Setup All do ApproachModel');
  //     // await resetLocator();
  //     // locator.reset();
  //     locator.reset();
  //     setupLocator();
  //     // resetLocator();
  //   });

  //   // tearDown(() async {
  //   //   locator.reset();
  //   //   // await database.close();
  //   // });

  //   test('list approaches', () async {
  //     await floorGateway.insertApproach(
  //       ApproachModel(
  //           dateTime: DateTime(2020, 01, 15).toIso8601String(),
  //           name: 'Harry Potter',
  //           description: 'Nice scar, homie',
  //           notes: 'Did sum wizard type of shit mane'),
  //     );
  //     await floorGateway.insertApproach(
  //       ApproachModel(
  //           dateTime: DateTime(2020, 02, 15).toIso8601String(),
  //           name: 'Joana Dark',
  //           description: 'Lady o nite',
  //           notes: 'Shining'),
  //     );
  //     //
  //     List<ApproachModel> list = await floorGateway.getAllApproach();
  //     list.forEach((element) {
  //       print(element.toJson());
  //     });

  //     expect(list[0].id, 2);
  //     expect(list[0].dateTime, DateTime(2020, 01, 15).toIso8601String());
  //     expect(list[1].name, 'Joana Dark');
  //     expect(list[1].description, 'Lady o nite');
  //     expect(list[1].notes, 'Shining');
  //   });

  //   test('set, read, delete approach', () async {
  //     List<PointModel> list = await PointFloorGateway().getAllPoint();

  //     list.forEach((element) {
  //       print('Id ${element.id}, name ${element.name}, Type ${element.pointType}');
  //     });

  //     await floorGateway.insertApproach(testApproachModel);
  //     ApproachModel approach = await floorGateway.getApproachById(1);
  //     expect(approach.id, 1);
  //     expect(approach.dateTime, testApproachModel.dateTime);
  //     expect(approach.name, testApproachModel.name);
  //     expect(approach.description, testApproachModel.description);
  //     expect(approach.notes, testApproachModel.notes);
  //     //
  //     await floorGateway.deleteApproachById(1);
  //     approach = await floorGateway.getApproachById(1);
  //     expect(approach, null);
  //   });

  //   test('Change approach', () async {
  //     ApproachModel oldApproach = await floorGateway.getApproachById(2);
  //     ApproachModel modifiedApproach = ApproachModel(
  //         id: 2,
  //         dateTime: DateTime(2020, 02, 15).toIso8601String(),
  //         name: 'Updated name',
  //         description: 'Updated description',
  //         notes: 'Updated note');

  //     await floorGateway.updateApproach(modifiedApproach);
  //     //
  //     ApproachModel updatedApproach = await floorGateway.getApproachById(2);
  //     //
  //     expect(updatedApproach.id, oldApproach.id);
  //     expect(updatedApproach.name, 'Updated name');
  //     expect(updatedApproach.description, 'Updated description');
  //     expect(updatedApproach.notes, 'Updated note');
  //   });
  // });
}
