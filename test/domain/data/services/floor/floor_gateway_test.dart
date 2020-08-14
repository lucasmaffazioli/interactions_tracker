import 'package:cold_app/data/models/interaction/interaction_views.dart';
import 'package:cold_app/data/models/interaction/goals_model.dart';
import 'package:matcher/matcher.dart';
import 'package:cold_app/core/enums/PointType.dart';
import 'package:cold_app/data/models/interaction/interaction_model.dart';
import 'package:cold_app/data/models/interaction/interaction_points_model.dart';
import 'package:cold_app/data/models/interaction/point_model.dart';
import 'package:cold_app/data/services/floor/floor_gateway.dart';
import 'package:cold_app/locator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() async {
    print('setupLocator');
    await setupLocatorTest();
  });

  tearDown(() {
    print('tearDown;');
    closeDb();
    locator.reset();
  });

  // List<PointModel> listPointOnCreate = [
  //   PointModel(id: null, name: 'Contato visual', pointType: PointTypeDataLayer.skill),
  //   PointModel(id: null, name: 'Postura física', pointType: PointTypeDataLayer.skill),
  //   PointModel(id: null, name: 'Projeção vocal', pointType: PointTypeDataLayer.skill),
  //   PointModel(id: null, name: 'Calibragem', pointType: PointTypeDataLayer.skill),
  //   PointModel(id: null, name: 'Frame', pointType: PointTypeDataLayer.skill),
  //   PointModel(id: null, name: 'Confiança', pointType: PointTypeDataLayer.skill),
  //   PointModel(id: null, name: 'Atração', pointType: PointTypeDataLayer.attraction),
  //   PointModel(id: null, name: 'Resultado', pointType: PointTypeDataLayer.result)
  // ];

  TestWidgetsFlutterBinding.ensureInitialized();
  PointFloorGateway pointFloorGateway = PointFloorGateway();
  InteractionFloorGateway interactionFloorGateway = InteractionFloorGateway();
  InteractionPointsFloorGateway interactionPointsFloorGateway = InteractionPointsFloorGateway();
  InteractionSummaryViewFloorGateway interactionViewsFloorGateway =
      InteractionSummaryViewFloorGateway();
  GoalsModelFloorGateway goalsModelFloorGateway = GoalsModelFloorGateway();

  PointModel testPointModel = PointModel(
    id: null,
    name: 'Beleza',
    pointType: PointType.attraction.toString(),
    item1: 'item1',
    item2: 'item2',
    item3: 'item3',
    item4: 'item4',
    item5: 'item5',
  );
  InteractionModel testInteractionModel = InteractionModel(
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

      PointModel point = await pointFloorGateway.getPointById(10);
      expect(point.id, 10);
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

      expect(list[0].name, 'Atração');
      expect(list[1].id, 7);
      expect(list[7].pointType, 'skill');
    });

    test('Change point', () async {
      await pointFloorGateway.insertPoint(testPointModel);
      PointModel oldPoint = await pointFloorGateway.getPointById(1);
      PointModel modifiedPoint = PointModel(
        id: oldPoint.id,
        name: 'Updated name',
        pointType: oldPoint.pointType,
        item1: 'item1',
        item2: 'item2',
        item3: 'item3',
        item4: 'item4',
        item5: 'item5',
      );
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
  /// - Interactions
  ///
  group('InteractionModel', () {
    test('set, read, delete interaction', () async {
      await interactionFloorGateway.insertInteraction(testInteractionModel);

      InteractionModel interaction = await interactionFloorGateway.getInteractionById(1);
      expect(interaction.id, 1);
      expect(interaction.dateTime, testInteractionModel.dateTime);
      expect(interaction.name, testInteractionModel.name);
      expect(interaction.description, testInteractionModel.description);
      expect(interaction.notes, testInteractionModel.notes);
      //
      await interactionFloorGateway.deleteInteraction(interaction);
      interaction = await interactionFloorGateway.getInteractionById(1);
      expect(interaction, null);
    });

    test('list interactions', () async {
      await interactionFloorGateway.insertInteraction(
        InteractionModel(
            dateTime: DateTime(2020, 01, 15).toIso8601String(),
            name: 'Harry Potter',
            description: 'Nice scar, homie',
            notes: 'Did sum wizard type of shit mane'),
      );
      await interactionFloorGateway.insertInteraction(
        InteractionModel(
            dateTime: DateTime(2020, 02, 15).toIso8601String(),
            name: 'Joana Dark',
            description: 'Lady o nite',
            notes: 'Shining'),
      );
      //
      List<InteractionModel> list = await interactionFloorGateway.getAllInteractions();
      // list.forEach((element) {
      //   print(element.toJson());
      // });

      expect(list[0].id, 1);
      expect(list[0].dateTime, DateTime(2020, 01, 15).toIso8601String());
      expect(list[1].name, 'Joana Dark');
      expect(list[1].description, 'Lady o nite');
      expect(list[1].notes, 'Shining');
    });

    test('Change interaction', () async {
      await interactionFloorGateway.insertInteraction(testInteractionModel);
      InteractionModel oldInteraction = await interactionFloorGateway.getInteractionById(1);
      InteractionModel modifiedInteraction = InteractionModel(
          id: 1,
          dateTime: DateTime(2020, 02, 15).toIso8601String(),
          name: 'Updated name',
          description: 'Updated description',
          notes: 'Updated note');

      await interactionFloorGateway.updateInteraction(modifiedInteraction);
      //
      InteractionModel updatedInteraction = await interactionFloorGateway.getInteractionById(1);
      //
      expect(updatedInteraction.id, oldInteraction.id);
      expect(updatedInteraction.name, 'Updated name');
      expect(updatedInteraction.description, 'Updated description');
      expect(updatedInteraction.notes, 'Updated note');
    });
  });

  group('InteractionPointsModel', () {
    setUp(() async {
      // print('Setup group interaction points');
    });

    test('Throws if wrong value', () async {
      expect(() => InteractionPointsModel(interactionId: 1, pointId: 1, value: 15),
          throwsA(TypeMatcher<ArgumentError>()));
      expect(() => InteractionPointsModel(interactionId: 1, pointId: 1, value: -1),
          throwsA(TypeMatcher<ArgumentError>()));
    });

    test('Insert, get, delete', () async {
      int interactionId = await interactionFloorGateway.insertInteraction(testInteractionModel);
      //
      interactionPointsFloorGateway.insertInteractionPoints(
          InteractionPointsModel(interactionId: interactionId, pointId: 1, value: 5));
      interactionPointsFloorGateway.insertInteractionPoints(
          InteractionPointsModel(interactionId: interactionId, pointId: 2, value: 7));
      //
      List<InteractionPointsModel> list =
          await interactionPointsFloorGateway.findInteractionPointsByInteractionId(interactionId);
      list.forEach((element) {
        print(element.toJson());
      });

      expect(list[0].interactionId, interactionId);
      expect(list[1].interactionId, interactionId);
      expect(list[0].pointId, 1);
      expect(list[1].pointId, 2);
      expect(list[0].value, 5);
      expect(list[1].value, 7);

      interactionPointsFloorGateway.deleteInteractionPointsByInteractionId(interactionId);
      list =
          await interactionPointsFloorGateway.findInteractionPointsByInteractionId(interactionId);
      expect(list, []);
    });
  });

  group('Interaction Views', () {
    test('Get average points', () async {
      await interactionFloorGateway.insertInteraction(
        InteractionModel(
            dateTime: DateTime(2020, 02, 15).toIso8601String(),
            name: 'Joana Dark',
            description: 'Lady o nite',
            notes: 'Shining'),
      );
      await interactionFloorGateway.insertInteraction(
        InteractionModel(
            dateTime: DateTime(2020, 02, 15).toIso8601String(),
            name: 'Harry Potter',
            description: 'Nice wizard',
            notes: 'Shining'),
      );

      interactionPointsFloorGateway
          .insertInteractionPoints(InteractionPointsModel(interactionId: 1, pointId: 1, value: 4));
      interactionPointsFloorGateway
          .insertInteractionPoints(InteractionPointsModel(interactionId: 1, pointId: 2, value: 1));
      interactionPointsFloorGateway
          .insertInteractionPoints(InteractionPointsModel(interactionId: 1, pointId: 7, value: 3));
      interactionPointsFloorGateway
          .insertInteractionPoints(InteractionPointsModel(interactionId: 1, pointId: 8, value: 1));
      interactionPointsFloorGateway
          .insertInteractionPoints(InteractionPointsModel(interactionId: 2, pointId: 3, value: 0));
      //

      List<InteractionSummaryView> list =
          await interactionViewsFloorGateway.findInteractionsSummary();
      list.forEach((element) {
        print(element.toJson());
      });
      //
      expect(list[0].id, 1);
      expect(list[0].name, 'Joana Dark');
      expect(list[0].dateTime, DateTime(2020, 02, 15).toIso8601String());
      expect(list[0].description, 'Lady o nite');
      expect(list[0].skill, 7.5);
      expect(list[0].attraction, 8);
      expect(list[0].result, null);
      expect(list[1].id, 2);
      expect(list[1].skill, 8);
      expect(list[1].difficulty, null);
      expect(list[1].attraction, null);
      expect(list[1].result, null);
    });
  });

  group('Goals Model', () {
    test('Test initial goal value', () async {
      GoalsModel goalsModel = await goalsModelFloorGateway.findGoalsModel();

      print(goalsModel.toJson());
      expect(goalsModel.id, 1);
      expect(goalsModel.weeklyInteractionGoal, 10);
    });

    test('Test change goal value', () async {
      goalsModelFloorGateway.saveGoalsModel(GoalsModel(5));
      GoalsModel goalsModel = await goalsModelFloorGateway.findGoalsModel();

      print(goalsModel.toJson());
      expect(goalsModel.id, 1);
      expect(goalsModel.weeklyInteractionGoal, 5);
    });
  });
}
