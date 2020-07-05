import 'package:cold_app/data/models/approach/approach_views.dart';
import 'package:matcher/matcher.dart';
import 'package:cold_app/core/enums/PointType.dart';
import 'package:cold_app/data/models/approach/approach_model.dart';
import 'package:cold_app/data/models/approach/approach_points_model.dart';
import 'package:cold_app/data/models/approach/point_model.dart';
import 'package:cold_app/data/services/floor/floor_gateway.dart';
import 'package:cold_app/locator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {
    print('setupLocator');
    setupLocator();
  });

  tearDown(() {
    print('tearDown;');
    closeDb();
    locator.reset();
  });

  TestWidgetsFlutterBinding.ensureInitialized();
  PointFloorGateway pointFloorGateway = PointFloorGateway();
  ApproachFloorGateway approachFloorGateway = ApproachFloorGateway();
  ApproachPointsFloorGateway approachPointsFloorGateway = ApproachPointsFloorGateway();
  ApproachSummaryViewFloorGateway approachViewsFloorGateway = ApproachSummaryViewFloorGateway();

  PointModel testPointModel =
      PointModel(id: null, name: 'Beleza', pointType: PointTypeDataLayer.attraction);
  ApproachModel testApproachModel = ApproachModel(
      dateTime: DateTime(2020, 01, 15).toIso8601String(),
      name: 'Harry Potter',
      description: 'Nice scar, homie',
      notes: 'Did sum wizard type of shit mane');

  group('PointModel', () {
    test('set, read, delete point', () async {
      await pointFloorGateway.insertPoint(testPointModel);

      List<PointModel> list = await pointFloorGateway.getAllPoint();
      list.forEach((element) {
        print('Id ${element.id}, name ${element.name}');
      });

      PointModel point = await pointFloorGateway.getPointById(9);
      expect(point.id, 9);
      expect(point.name, testPointModel.name);
      expect(point.pointType, testPointModel.pointType);
      //
      await pointFloorGateway.deletePointById(1);
      point = await pointFloorGateway.getPointById(1);
      expect(point, null);
    });

    test('list points', () async {
      List<PointModel> list = await pointFloorGateway.getAllPoint();

      // list.forEach((element) {
      //   print('Id ${element.id}, name ${element.name}, Type ${element.pointType}');
      // });

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
    test('set, read, delete approach', () async {
      await approachFloorGateway.insertApproach(testApproachModel);

      ApproachModel approach = await approachFloorGateway.getApproachById(1);
      expect(approach.id, 1);
      expect(approach.dateTime, testApproachModel.dateTime);
      expect(approach.name, testApproachModel.name);
      expect(approach.description, testApproachModel.description);
      expect(approach.notes, testApproachModel.notes);
      //
      await approachFloorGateway.deleteApproachById(1);
      approach = await approachFloorGateway.getApproachById(1);
      expect(approach, null);
    });

    test('list approaches', () async {
      await approachFloorGateway.insertApproach(
        ApproachModel(
            dateTime: DateTime(2020, 01, 15).toIso8601String(),
            name: 'Harry Potter',
            description: 'Nice scar, homie',
            notes: 'Did sum wizard type of shit mane'),
      );
      await approachFloorGateway.insertApproach(
        ApproachModel(
            dateTime: DateTime(2020, 02, 15).toIso8601String(),
            name: 'Joana Dark',
            description: 'Lady o nite',
            notes: 'Shining'),
      );
      //
      List<ApproachModel> list = await approachFloorGateway.getAllApproach();
      // list.forEach((element) {
      //   print(element.toJson());
      // });

      expect(list[0].id, 1);
      expect(list[0].dateTime, DateTime(2020, 01, 15).toIso8601String());
      expect(list[1].name, 'Joana Dark');
      expect(list[1].description, 'Lady o nite');
      expect(list[1].notes, 'Shining');
    });

    test('Change approach', () async {
      await approachFloorGateway.insertApproach(testApproachModel);
      ApproachModel oldApproach = await approachFloorGateway.getApproachById(1);
      ApproachModel modifiedApproach = ApproachModel(
          id: 1,
          dateTime: DateTime(2020, 02, 15).toIso8601String(),
          name: 'Updated name',
          description: 'Updated description',
          notes: 'Updated note');

      await approachFloorGateway.updateApproach(modifiedApproach);
      //
      ApproachModel updatedApproach = await approachFloorGateway.getApproachById(1);
      //
      expect(updatedApproach.id, oldApproach.id);
      expect(updatedApproach.name, 'Updated name');
      expect(updatedApproach.description, 'Updated description');
      expect(updatedApproach.notes, 'Updated note');
    });
  });

  group('ApproachPointsModel', () {
    setUp(() async {
      // print('Setup group approach points');
    });

    test('Throws if wrong value', () async {
      expect(() => ApproachPointsModel(approachId: 1, pointId: 1, value: 15),
          throwsA(TypeMatcher<ArgumentError>()));
      expect(() => ApproachPointsModel(approachId: 1, pointId: 1, value: -1),
          throwsA(TypeMatcher<ArgumentError>()));
    });

    test('Insert, get, delete', () async {
      await approachFloorGateway.insertApproach(testApproachModel);
      int approachId = await approachFloorGateway.findLastInsertedApproach();
      //
      approachPointsFloorGateway
          .insertApproachPoints(ApproachPointsModel(approachId: approachId, pointId: 1, value: 5));
      approachPointsFloorGateway
          .insertApproachPoints(ApproachPointsModel(approachId: approachId, pointId: 2, value: 7));
      //
      List<ApproachPointsModel> list =
          await approachPointsFloorGateway.findApproachPointsByApproachId(approachId);
      list.forEach((element) {
        print(element.toJson());
      });

      expect(list[0].approachId, approachId);
      expect(list[1].approachId, approachId);
      expect(list[0].pointId, 1);
      expect(list[1].pointId, 2);
      expect(list[0].value, 5);
      expect(list[1].value, 7);

      approachPointsFloorGateway.deleteApproachPointsByApproachId(approachId);
      list = await approachPointsFloorGateway.findApproachPointsByApproachId(approachId);
      expect(list, []);
    });
  });

  group('Approach Views', () {
    test('Get average points', () async {
      await approachFloorGateway.insertApproach(
        ApproachModel(
            dateTime: DateTime(2020, 02, 15).toIso8601String(),
            name: 'Joana Dark',
            description: 'Lady o nite',
            notes: 'Shining'),
      );
      await approachFloorGateway.insertApproach(
        ApproachModel(
            dateTime: DateTime(2020, 02, 15).toIso8601String(),
            name: 'Harry Potter',
            description: 'Nice wizard',
            notes: 'Shining'),
      );

      approachPointsFloorGateway
          .insertApproachPoints(ApproachPointsModel(approachId: 1, pointId: 1, value: 10));
      approachPointsFloorGateway
          .insertApproachPoints(ApproachPointsModel(approachId: 1, pointId: 2, value: 5));
      approachPointsFloorGateway
          .insertApproachPoints(ApproachPointsModel(approachId: 1, pointId: 7, value: 7));
      approachPointsFloorGateway
          .insertApproachPoints(ApproachPointsModel(approachId: 1, pointId: 8, value: 8));
      approachPointsFloorGateway
          .insertApproachPoints(ApproachPointsModel(approachId: 2, pointId: 3, value: 8));
      //

      List<ApproachSummaryView> list = await approachViewsFloorGateway.findApproachesSummary();
      list.forEach((element) {
        print(element.toJson());
      });
      //
      expect(list[0].id, 1);
      expect(list[0].name, 'Joana Dark');
      expect(list[0].dateTime, DateTime(2020, 02, 15).toIso8601String());
      expect(list[0].description, 'Lady o nite');
      expect(list[0].skill, 7.5);
      expect(list[0].attraction, 7);
      expect(list[0].result, 8);
      expect(list[1].id, 2);
      expect(list[1].skill, 8);
      expect(list[1].attraction, null);
      expect(list[1].result, null);
    });
  });
}
