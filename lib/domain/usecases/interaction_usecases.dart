// Isto aqui NÃO CONHECE o banco de dados

import 'dart:convert';

import 'package:cold_app/core/enums/PointType.dart';
import 'package:cold_app/data/models/interaction/interaction_model.dart';
import 'package:cold_app/data/models/interaction/interaction_points_model.dart';
import 'package:cold_app/data/models/interaction/interaction_views.dart';
import 'package:cold_app/data/models/interaction/point_model.dart';
import 'package:cold_app/data/services/floor/floor_gateway.dart';
import 'package:cold_app/data/services/storage.dart';
import 'package:cold_app/domain/entities/interaction/interaction_entity.dart';
import 'package:cold_app/presentation/common/constants.dart';

InteractionFloorGateway interactionFloorGateway = InteractionFloorGateway();
InteractionPointsFloorGateway interactionPointsFloorGateway = InteractionPointsFloorGateway();
PointFloorGateway pointFloorGateway = PointFloorGateway();
InteractionPointsViewFloorGateway interactionPointsViewFloorGateway =
    InteractionPointsViewFloorGateway();
InteractionSummaryViewFloorGateway interactionSummaryViewFloorGateway =
    InteractionSummaryViewFloorGateway();

class DeleteInteraction {
  Future<void> call(int id) async {
    return await interactionFloorGateway
        .deleteInteraction(InteractionModel(id: id, name: '', description: '', dateTime: ''));
  }
}

class SaveInteraction {
  void call(InteractionEntity interaction) async {
    int interactionId;
    InteractionModel interactionFromDb;
    print('Save interaction');
    print(interaction.toJson());

    ///
    /// For the case of a import from backup interaction
    if (interaction.id != null && interaction.id != 0) {
      interactionFromDb = await interactionFloorGateway.getInteractionById(interaction.id);
    }

    if (interaction.id == null || interaction.id == 0 || interactionFromDb == null) {
      interactionId = await interactionFloorGateway.insertInteraction(InteractionModel(
        id: interaction.id,
        name: interaction.name,
        dateTime: interaction.dateTime.toIso8601String(),
        description: interaction.description,
        notes: interaction.notes,
      ));

      // TODO - ERROR HANDLING
      if (interactionId != null && interactionId != 0) {
        interaction.points.forEach((element) async {
          try {
            await interactionPointsFloorGateway.insertInteractionPoints(InteractionPointsModel(
              interactionId: interactionId,
              pointId: element.id,
              value: element.value,
            ));
          } catch (e) {
            print('Erro ao inserir pontos! ' + e.toString());
          }
        });
      }
    } else {
      interactionId = interaction.id;
      await interactionFloorGateway.updateInteraction(InteractionModel(
        id: interaction.id,
        name: interaction.name,
        dateTime: interaction.dateTime.toIso8601String(),
        description: interaction.description,
        notes: interaction.notes,
      ));

      if (interactionId != null && interactionId != 0) {
        interaction.points.forEach((element) async {
          try {
            await interactionPointsFloorGateway.updateInteractionPoints(InteractionPointsModel(
              interactionId: interactionId,
              pointId: element.id,
              value: element.value,
            ));
          } catch (e) {
            print('Erro ao inserir pontos! ' + e.toString());
          }
        });
      }
    }

    //
    //

    // InteractionEntity ap = await GetInteraction().call(interactionId);
    // print('Inserted interaction:');
    // print(ap.toJson());
  }
}

class ExportAllInteractionsJson {
  Future<String> call() async {
    List<InteractionModel> listModels = await interactionFloorGateway.getAllInteractions();
    List<InteractionEntity> listInteraction = [];
    List<Map> listMap = [];

    for (InteractionModel e in listModels) {
      listInteraction.add(await GetInteraction().call(e.id));
      print('e');
      print(e.toJson());
    }

    if (listInteraction != null) {
      listInteraction.forEach((element) {
        listMap.add(element.toMap());
      });

      print('json.encode(listMap)');
      print(json.encode(listMap));
    }
    print('Saving file to:');
    final String savedPath =
        await Storage().saveExternalFile('Interactions.json', json.encode(listMap));
    print(savedPath);

    return savedPath;
  }
}

class ImportInteractionsJson {
  Future<int> call() async {
    final String source = await Storage().readExternalFile('Interactions.json');

    final List<dynamic> listMap = json.decode(source);

    for (dynamic e in listMap) {
      final InteractionEntity interaction = InteractionEntity.fromMap(e);

      if (listMap == null) print(listMap);

      await SaveInteraction().call(interaction);

      print('interaction.toJson()');
      print(interaction.toJson());
    }
    print(listMap);

    return listMap.length;
  }
}

class GetInteraction {
  Future<InteractionEntity> call(int id) async {
    InteractionModel interactionModel;
    //
    InteractionEntity interaction;
    List<InteractionPointEntity> points = [];
    //
    if (id == null) {
      List<PointModel> allPointsModel = await pointFloorGateway.getAllPoint();
      allPointsModel.forEach((element) {
        points.add(InteractionPointEntity(
          id: element.id,
          name: element.name,
          pointType: getPointTypeFromString(element.pointType),
          value: Constants.minPoints,
          item1: element.item1,
          item2: element.item2,
          item3: element.item3,
          item4: element.item4,
          item5: element.item5,
        ));
        interaction = InteractionEntity(
          id: null,
          name: '',
          description: '',
          dateTime: DateTime.now(),
          points: points,
        );
      });
    } else {
      interactionModel = await interactionFloorGateway.getInteractionById(id);

      List<InteractionPointsView> interactionPointsView =
          await interactionPointsViewFloorGateway.findInteractionsPointsByInteractionId(id);

      // List<PointModel> allPointsModel = await pointFloorGateway.getAllPoint();
      // allPointsModel.forEach((element) {
      //   print(element.toJson());
      // });
      //
      //
      interactionPointsView.forEach((element) {
        print(element.toJson());
        points.add(InteractionPointEntity(
          id: element.pointId,
          name: element.pointName,
          pointType: getPointTypeFromString(element.pointType),
          value: element.pointValue,
          item1: element.item1,
          item2: element.item2,
          item3: element.item3,
          item4: element.item4,
          item5: element.item5,
        ));
        interaction = InteractionEntity(
          id: interactionModel.id,
          name: interactionModel.name,
          description: interactionModel.description,
          notes: interactionModel.notes,
          dateTime: DateTime.parse(interactionModel.dateTime),
          points: points,
        );
      });
    }
    //
    return interaction;
  }
}

class GetAllSummaryInteractionsStream {
  Stream<List<InteractionSummaryView>> call() {
    return interactionSummaryViewFloorGateway.findInteractionsSummaryStream();
  }
}
